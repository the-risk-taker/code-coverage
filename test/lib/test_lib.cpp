#include "library.hpp"
#include <cassert>
#include <stdexcept>

int main()
{
    assert(add(2, 3) == 5);
    assert(subtract(5, 3) == 2);
    assert(divide(6, 3) == 2);

    try
    {
        divide(5, 0);
        assert(false);
    }
    catch (const std::invalid_argument& e)
    {
        assert(std::string(e.what()) == "b cannot be zero");
    }

    return 0;
}
