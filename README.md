# Learning Engine Starter

Edit code on macOS in VS Code. Compile and run inside one Linux container.

Your host repo is bind-mounted at `/workspace`.

## First run

```bash
docker compose build
docker compose run --rm drills
```

Inside the container:

```bash
pwd
ls
```

## Compile and run C++

```bash
mkdir -p build
g++ -std=c++20 -Wall -Wextra -Wpedantic -Werror -g \
  src/cpp/day1/running_sum.cpp \
  -o build/running_sum_cpp
./build/running_sum_cpp
```

## Compile and run C

```bash
mkdir -p build
gcc -std=c17 -Wall -Wextra -Wpedantic -Werror -g \
  src/c/day1/running_sum.c \
  -o build/running_sum_c
./build/running_sum_c
```

## Run Python

```bash
python3 src/python/day1/running_sum.py
```

## Leave the container

```bash
exit
```

## POE-RTR loop

```text
PREDICT
→ IMPLEMENT FROM BLANK
→ OBSERVE
→ EXPLAIN THE DELTA
→ DELETE + REWRITE
→ TRANSFER
```
