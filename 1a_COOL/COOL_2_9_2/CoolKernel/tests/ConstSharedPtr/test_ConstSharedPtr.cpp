#include <iostream>
#include <boost/shared_ptr.hpp>

class MyClass
{
public:
  MyClass() : m_i(0) {}
  const int getI() const { return m_i; }
  void setI( const int i ) { m_i = i; }
private:
  int m_i;
};

int main ( int, char** )
{

  // MyClass object
  {
    MyClass mc;
    std::cout << "MyClass" << std::endl;
    std::cout << "i = " << mc.getI() << std::endl;
    mc.setI(1);
    std::cout << "i = " << mc.getI() << std::endl;
  }

  // Const MyClass object
  {
    const MyClass mc;
    std::cout << "const MyClass" << std::endl;
    std::cout << "i = " << mc.getI() << std::endl;
    //mc.setI(1); // does NOT compile
    std::cout << "i = " << mc.getI() << std::endl;
  }

  // Pointer to MyClass
  {
    MyClass* pMc = new MyClass();
    try {
      std::cout << "MyClass*" << std::endl;
      std::cout << "i = " << pMc->getI() << std::endl;
      pMc->setI(1);
      std::cout << "i = " << pMc->getI() << std::endl;
    } catch (...) {
      delete pMc;
    }
  }

  // Const pointer to MyClass
  {
    const MyClass* pMc = new MyClass();
    try {
      std::cout << "const MyClass*" << std::endl;
      std::cout << "i = " << pMc->getI() << std::endl;
      //pMc->setI(1); // does NOT compile
      std::cout << "i = " << pMc->getI() << std::endl;
    } catch (...) {
      delete pMc;
    }
  }

  // Auto pointer to MyClass
  {
    std::auto_ptr<MyClass> pMc( new MyClass() );
    std::cout << "auto_ptr<MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    pMc->setI(1);
    std::cout << "i = " << pMc->getI() << std::endl;
  }

  // Const auto pointer to MyClass
  {
    const std::auto_ptr<MyClass> pMc( new MyClass() );
    std::cout << "const auto_ptr<MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    pMc->setI(1); // DOES compile!
    std::cout << "i = " << pMc->getI() << std::endl;
  }

  // Auto pointer to const MyClass
  {
    std::auto_ptr<const MyClass> pMc( new MyClass() );
    std::cout << "auto_ptr<const MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    //pMc->setI(1); // does NOT compile
    std::cout << "i = " << pMc->getI() << std::endl;
  }

  // Shared pointer to MyClass
  {
    boost::shared_ptr<MyClass> pMc( new MyClass() );
    std::cout << "shared_ptr<MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    pMc->setI(1);
    std::cout << "i = " << pMc->getI() << std::endl;
  }

  // Const shared pointer to MyClass
  {
    const boost::shared_ptr<MyClass> pMc( new MyClass() );
    std::cout << "const shared_ptr<MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    pMc->setI(1); // DOES compile!
    std::cout << "i = " << pMc->getI() << std::endl;
  }

  // Shared pointer to const MyClass
  {
    boost::shared_ptr<const MyClass> pMc( new MyClass() );
    std::cout << "shared_ptr<const MyClass>" << std::endl;
    std::cout << "i = " << pMc->getI() << std::endl;
    //pMc->setI(1); // does NOT compile
    std::cout << "i = " << pMc->getI() << std::endl;
  }

}
