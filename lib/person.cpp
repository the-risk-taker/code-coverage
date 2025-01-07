#include "person.hpp"
#include <vector>

Person::Person() = default;

void Person::setName(const std::string& name)
{
    static std::vector<std::string> v = {"Bob"};
    v.push_back(name);

    m_name = name;
}

std::string Person::getName() const
{
    return m_name;
}
