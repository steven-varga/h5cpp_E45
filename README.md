# H5CPP E45

[clang error:#41 ](https://github.com/steven-varga/h5cpp/issues/41) originally reported by [Matthew R Johnson](https://github.com/mrj10)
related to inheriting ctor-s, discussed in [N2540](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2540.htm)
compiler error typically manifesting as:
```
error: no member named '' in 'A<char, 0>'
h5cpp_e45.cpp:20:15: note: in instantiation of template class 'A<char, 1>' requested here
    A<char,1> v2;               // this line fails

```
### reproduce error
1. download and install clang > v6.0, possibly clang++-7 clang++-8 clang++-9 clang++10
2. edit makefile `compilers` section to reflect available compiler versions
3. `make test-with-compilers` will produce captured `output.txt`

```
.
├── clang++-6.0
│   ├── h5cpp_e45.o
│   └── output.txt
├── clang++-7
│   └── output.txt
├── clang++-8
│   └── output.txt
├── clang++-9
│   └── output.txt
├── g++-7
│   ├── h5cpp_e45.o
│   └── output.txt
├── g++-8
│   ├── h5cpp_e45.o
│   └── output.txt
├── g++-9
│   ├── h5cpp_e45.o
│   └── output.txt
├── h5cpp_e45.cpp
├── Makefile
└── README.md
```


which may be reproduced with:
```
template <class T, int tag> struct A {};
template<class T> struct A<T,0> {};
template<class T> struct B {};

template<class T> struct A<T,1> : public A<T,0> {
    using parent = A<T,0>;
    using parent::A;           // comment this line out, and un-comment the following line
    //using A<T,0>::A;         // prevents CLANG compiler error 
};

template<class T> struct A<T,2> : public B<T> {
    using parent = B<T>;
    using parent::B;           // No problem
};

int main(){
    A<int,0> v1;
    A<char,1> v2;               // this line fails
    A<char,2> v3;               // this passes
}
```

with clang 7.0 and greater, but not any variant of gcc
