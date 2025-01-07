find_program(GCOV gcov)
find_program(LCOV lcov)
find_program(GENHTML genhtml)

if(GCOV AND LCOV AND GENHTML)
    set(GCOV_OUTPUT_DIR ${CMAKE_BINARY_DIR}/coverage-gcov)
    add_custom_target(run-gcov
        COMMAND ${CMAKE_COMMAND} -E echo "[1/3] Removing counters - old .gcda and .gcov data"
            COMMAND ${CMAKE_COMMAND} -E remove -f `find ${CMAKE_BINARY_DIR} -name "*.gcov" `
            COMMAND ${CMAKE_COMMAND} -E remove -f `find ${CMAKE_BINARY_DIR} -name "*.gcda" `
        COMMAND ${CMAKE_COMMAND} -E echo "[2/3] Running tests - generating .gcda data"
            COMMAND test_lib
            COMMAND test_person
        COMMAND ${CMAKE_COMMAND} -E echo "[3/3] Running gcov"
            COMMAND ${CMAKE_COMMAND} -E make_directory ${GCOV_OUTPUT_DIR}
            COMMAND ${CMAKE_COMMAND} -E chdir ${GCOV_OUTPUT_DIR} ${GCOV} --human-readable --unconditional-branches --demangled-names --branch-probabilities --branch-counts `find ${CMAKE_BINARY_DIR}/lib -name "*.gcno" `
        COMMAND ${CMAKE_COMMAND} -E echo "Examine output in ${GCOV_OUTPUT_DIR}"
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        USES_TERMINAL
        COMMENT "Running gcov report"
    )

    # NOTE: Put here exclude patterns for files which should be excluded from coverage report (like system headers)
    set(LCOV_EXCLUDES
        --exclude='/usr/*'
        --exclude='*/test/*'
    )
    # NOTE: Put here exclude patterns for files which should be excluded from coverage report which are not covered by tests (like app sources in this case)
    set(LCOV_EXCLUDES_INITIAL
        --exclude='*/app/*'
    )
    add_custom_target(generate-coverage-report
        COMMAND ${CMAKE_COMMAND} -E echo "[1/6] Removing counters - old .gcda data"
            COMMAND ${LCOV} --zerocounters --directory .
        COMMAND ${CMAKE_COMMAND} -E echo "[2/6] Creating baseline coverage data"
            COMMAND ${LCOV} --capture --directory=${CMAKE_BINARY_DIR} ${LCOV_EXCLUDES} ${LCOV_EXCLUDES_INITIAL} --output-file=coverage-lcov-initial.info --initial --branch-coverage --filter branch
        COMMAND ${CMAKE_COMMAND} -E echo "[3/6] Running tests - generating .gcda data"
            COMMAND $<TARGET_FILE:test_lib>
            COMMAND $<TARGET_FILE:test_person>
        COMMAND ${CMAKE_COMMAND} -E echo "[4/6] Creating test coverage data"
            COMMAND ${LCOV} --capture --directory=${CMAKE_BINARY_DIR} ${LCOV_EXCLUDES} --output-file=coverage-lcov-test.info --branch-coverage --filter branch
        COMMAND ${CMAKE_COMMAND} -E echo "[5/6] Combining baseline and test coverage data"
            COMMAND ${LCOV}  --add-tracefile coverage-lcov-initial.info --add-tracefile coverage-lcov-test.info -o coverage-lcov-total.info --branch-coverage --filter branch
        COMMAND ${CMAKE_COMMAND} -E echo "[6/6] Generating HTML report"
        COMMAND ${GENHTML} --demangle-cpp --output-directory=coverage-html coverage-lcov-total.info --show-details --legend --branch-coverage --filter branch
        COMMAND ${CMAKE_COMMAND} -E echo "Report generated - see ${CMAKE_BINARY_DIR}/coverage-html/index.html"
        DEPENDS app
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        USES_TERMINAL
        COMMENT "Generating HTML coverage report"
    )

    message(STATUS "Code coverage tools found, use 'run-gcov' or 'generate-coverage-report' targets")
else()
    message(STATUS "Code coverage tools not found, generating coverage report is disabled")
endif()
