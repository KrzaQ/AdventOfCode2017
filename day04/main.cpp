#include <algorithm>
#include <iostream>
#include <iterator>
#include <fstream>
#include <sstream>
#include <string>
#include <unordered_set>
#include <vector>

using namespace std;

int main()
{
    fstream infile("data.txt");
    string line;
    vector<vector<string>> data;
    while(getline(infile, line)) {
        stringstream splitter{line};
        vector<string> split;
        copy(istream_iterator<string>(splitter), {}, back_inserter(split));
        data.push_back(move(split));
    }

    auto p1 = count_if(data.cbegin(), data.cend(), [](auto const& row){
        unordered_set<string> s(row.begin(), row.end());
        return s.size() == row.size();
    });

    auto p2 = count_if(data.cbegin(), data.cend(), [](auto row){
        for_each(row.begin(), row.end(), [](auto& str){ sort(str.begin(), str.end()); });
        unordered_set<string> s(row.begin(), row.end());
        return s.size() == row.size();
    });

    cout << "Part 1: " << p1 << endl;
    cout << "Part 2: " << p2 << endl;
}
