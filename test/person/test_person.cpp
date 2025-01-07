#include "person.hpp"
#include <cassert>

int main()
{
    Person person;
    person.setName("Alice");
    assert(person.getName() == "Alice");

    return 0;
}
