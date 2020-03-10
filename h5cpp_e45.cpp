

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
