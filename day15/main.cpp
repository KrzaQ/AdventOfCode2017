#include <iostream>
#include <utility>

static constexpr const std::pair A = { 512uLL, 16807u };
static constexpr const std::pair B = { 191uLL, 48271u };
static constexpr const auto mod = 2'147'483'647uLL;

template<typename T, typename U = int>
auto make_generator(T&& initializer, U&& divisible_by = 1)
{
    auto [value, mult] = initializer;
    
    auto next = [mult, divisible_by](auto&& val){
        do{ val = val * mult % mod; } while(val % divisible_by > 0);
        return val;
    };
 
    value = next(value);
    
    return [=] () mutable {
        return std::exchange(value, next(value));
    };
}

int main()
{
    {
        auto as = make_generator(A);
        auto bs = make_generator(B);
        int count{};
        for(int i = 0; i < 40'000'000; ++i)
            if((as() & 0xFFFF) == (bs() & 0xFFFF))
                ++count;
        std::cout << "Part 1: " << count << '\n';
    }
    {
        auto as = make_generator(A,4);
        auto bs = make_generator(B,8);
        int count{};
        for(int i = 0; i < 5'000'000; ++i)
            if((as() & 0xFFFF) == (bs() & 0xFFFF))
                ++count;
        std::cout << "Part 2: " << count << '\n';
    }
}
