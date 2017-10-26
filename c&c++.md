## explicit  
```
class A
{
    public:
        A(int j):i(j){} // 默认implicit
        int i;
};
A a=2;// ok  

class A
{
    public:
        explicit A(int j):i(j){} 
        int i;
};
A a=2;// error 无法隐式转换
A a(2);// ok 

class A
{
    public:
        explicit A(int j,int h):i(j+h){}
        int i;
};
A a(2);// error explicit修饰的构造函数如果有多个形参，则其中一个形参必须有默认值


```
