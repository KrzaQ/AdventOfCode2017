#include <cassert>
#include <climits>
#include <cmath>
#include <csetjmp>
#include <cstdlib>
#include <cstring>
#include <cstdarg>
#include <cctype>

#include <algorithm>
#include <array>
#include <atomic>
#include <chrono>
#include <complex>
#include <fstream>
#include <functional>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <list>
#include <locale>
#include <map>
#include <memory>
#include <mutex>
#include <random>
#include <regex>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>
#include <thread>
#include <type_traits>
#include <typeinfo>
#include <typeindex>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <locale>

using namespace std;
[[maybe_unused]] constexpr int Width = 60;
#define DBG(x) { cout << right << setw(Width) << #x << " " << boolalpha << (x) << endl; }
#define DBG_CONT(x) { cout << left << setw(Width) << #x; for(auto const& _name : (x)) \
    cout << boolalpha << _name << " "; cout << endl; }
#define DBG_LINE(x) { cout << right << setw(4) << __LINE__ << " "; DBG(x); }
#define BARK cout << right << setw(4) << __LINE__  << " " << __PRETTY_FUNCTION__ << endl;

auto main() -> int
{
    int64_t a = 1;
    int64_t b = 67;
    int64_t c = 67;
    int64_t d = 0;
    int64_t e = 0;
    int64_t f = 0;
    int64_t g = 0;
    int64_t h = 0;

    int muls{};
    if(a) {
        b = 106700;
        c = 123700;
    }
    while(true) {
        f = 1;
        d = 2;
        do {
            e = 2;
            do {
                g = d;
                g *= e;
                muls++;
                g -= b;
                if(!g)
                    f = 0;
                e++;
                g = e;
                g -= b;
            } while(g);
            d++;
            g = d;
            g -= b;
        } while(g);
        if(!f)
            h++;
        g = b;
        g -= c;
        if(!g){
            DBG(h);
            break;
        }
        b += 17;
        cout << string(80, '=') << endl;
        DBG(a);
        DBG(b);
        DBG(c);
        DBG(d);
        DBG(e);
        DBG(f);
        DBG(g);
        DBG(h);
    }
    DBG(muls);
}

