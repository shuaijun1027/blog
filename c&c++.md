## 引用声明  
``` c++
int i=20;// ok i是Lvalue
int& i=20;// error 
```  

## explicit  
``` c++ 
class A
{
    public:
        A(int j):i(j){} // 默认implicit
        int i;
};
A a=2;// ok i=2

class A
{
    public:
        explicit A(int j):i(j){} 
        int i;
};
A a=2;// error 无法隐式转换
A a(2);// ok i=2

explicit A(int j,int h):i(j+h){}
A a(2);// error explicit修饰的构造函数如果有多个形参，则其中一个形参必须有默认值

explicit A(int j,int h=1):i(j+h){}
A a(2);// ok 3

explicit A(int j=1,int h):i(j+h){}
A a(2);// error 实参2赋值给形参j，h没有默认值

explicit A(int j=1,int h=1):i(j+h){}
A a(2);// ok 3

explicit A(int j=1,int h=1):i(j+h){}
A a();// error 无法调用无参构造函数
```   

## auto  
``` c++  
int i=20;
auto a=i;// ok 20


```  

