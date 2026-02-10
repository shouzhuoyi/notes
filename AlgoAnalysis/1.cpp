#include <iostream>
using namespace std;

int main() {

  for (int i = 1; i <= 11; i++) {
    printf("#include(\"chaptersTypst/chapter%d.typ\")\n", i);
  }
}