#ifndef PERSON_HPP
#define PERSON_HPP

#include <string>

class Person
{
  public:
    Person();

    void setName(const std::string& name);
    std::string getName() const;

  private:
    std::string m_name;
};

#endif   // PERSON_HPP
