#include "library.hpp"
#include <stdexcept>

int add(int a, int b)
{
    return a + b;
}

int subtract(int a, int b)
{
    return a - b;
}

int divide(int a, int b)
{
    if (b == 0)
    {
        throw std::invalid_argument("b cannot be zero");
    }
    return a / b;
}
