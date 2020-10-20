# Kush

![Cover](https://github.com/itssamuelrowe/kush/blob/master/images/cover.jpg?raw=true)

Kush is a general purpose programming language designed to build simple, safe
and efficient programs. It is heavily inspired by C, Go, JavaScript, and Lua.

### Example 1: Linear Search

The following example demonstrates the linear search algorithm in Kush.

```
boolean equals(string s1, string s2) {
    boolean result = false;
    if s1 == s2 {
        result = true;
    }
    else if s1.value.size == s2.value.size {
        result = true;
        i32 i = 0;
        while i < s1.value.size {
            if (s1.value[i] != s2.value[i]) {
                result = false;
                break;
            }
            i += 1;
        }
    }
    return result;
}

i32 search(string[] array, string key) {
    i32 result = -1;
    i32 i = 0;
    while i < array.size {
        if equals(array[i], key) {
            result = i;
            break;
        }
        i += 1;
    }
    return result;
}

void main() {
    var array = [
        'Samuel Rowe',
        'Joel Rego',
        'Akshay',
        'Arshad Ahmed',
        'Sreem Chowdhary'
    ];
    string key = 'Kush';

    i32 result = search(array, key);
    if result != -1 {
        print_s('Found the result at ');
        print_i(result);
        print_s('!\n');
    }
    else {
        print_s('Could not find \"');
        print_s(key);
        print_s('\" in the array.\n');
    }
}
```

### Example 2: Factorial

The following example demonstrates calculation of factorial in Kush.
```
void main() {
    var n = 5;
    var result = 1;
    var i = 1;
    while i <= n {
        result *= i;
        i += 1;
    }

    print_s('The factorial of 5 is ');
    print_i(result);
    print_s('.\n');
}
```

### Example 3: Counter

The following example demonstrates closures (currently unavailable) in Kush.

```
function Counter = i32 ();

Counter makeCounter(i32 i) {
    return @ -> i += 1;
}

void main() {
    var next = makeCounter(-1);
    while next() < 10 {
        print('Hello, world!');
    }
}
```

## Installation

Before you install Kush, you need to install NodeJS, Yarn, and ANTLR your system.

```
sudo apt install antlr4
./build
```

Create a file called "test.kush" with the following content:
```c
void main() {
    print("Hello, world!");
}
```

You can trigger the compiler with the following command:
```
node source/index
```

or

```
yarn start
```

## Contributing

We welcome all contributors.

Kush was created with a vision to help programmers, like you and I, write code
better. With your contributions, we can get there sooner. We appreciate your help!

## License

Copyright (C) 2020 Samuel Rowe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
