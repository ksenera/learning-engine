# C++ Spine + Python Transfer + C Substrate: Four-Day Compression Sprint

## Calendar

Use Tuesday, June 2 through Friday, June 5 for the four implementation days.  
Use Saturday, June 6 as the blank-page proof run and cleanup buffer.

## Objective

The goal is not encyclopedic language mastery. The measurable target is:

```text
derive small programs from plain English
→ identify state and invariant
→ implement from blank in restricted C++
→ trace execution
→ port the kernel to Python
→ use C selectively to expose the substrate
```

## Language Roles

```text
C++: primary construction language
Python: translation layer for ML and internal tooling
C: substrate probes for arrays, pointers, and explicit memory
Rust: parking lot until the C++/C memory model is stable
```

## Restricted C++ Vocabulary

Use only:

```text
int, double, bool
std::vector, std::array, std::string, std::unordered_map
functions, const references
if / else, for / while
assert
struct
class only on Day 4
```

Do not chase templates, smart pointers, manual heap allocation, metaprogramming, advanced STL algorithms, Rust syntax, or CUDA during this sprint.

---

# Learning Loop

For every drill:

```text
PREDICT
→ IMPLEMENT FROM BLANK
→ OBSERVE
→ EXPLAIN THE DELTA
→ DELETE + REWRITE
→ PORT TO PYTHON
→ TRANSFER
```

For selected probes:

```text
REIMPLEMENT IN C
→ identify what C++ hid
```

## Pre-run scaffold

```text
DRILL:
INPUT:
OUTPUT:

CONTENT LEVELS:
Level 0 atoms:
Level 1 control:
Level 2 operation family:
Level 3 invariant:

VALUES:
NAMES:
STATE:
FLOW:
INVARIANT:
EXPECTED OUTPUT:
EDGE CASES:
```

## Post-run delta log

```text
OBSERVATION:
WHAT MATCHED:
WHAT DIVERGED:
MISSING STATE:
WEAK OR WRONG INVARIANT:
SYNTAX GAP:
CORRECT MODEL:
TRANSFER:
```

---

# Day 1 — Linear State, Loops, and Indexed Sequences

Primary executable model:

```text
read stable input
→ update explicit state
→ preserve invariant
→ return result
```

## C++ drills

1. `running_sum([1,2,3,4]) -> 10`  
   Kernel: accumulator, reduce.  
   Invariant: after processing the first `k` values, `total` equals their sum.

2. `count_positive([1,-2,0,4,-5]) -> 2`  
   Kernel: accumulator, branch, filter + reduce.

3. `running_max([4,1,9,2]) -> 9`  
   Kernel: accumulator, comparison, branch.  
   Design question: what should happen for empty input?

4. `copy_values([1,2,3]) -> [1,2,3]`  
   Constraint: build a new vector manually.  
   Kernel: traverse, append, map identity.

5. `elementwise_add([1,2,3],[10,20,30]) -> [11,22,33]`  
   Kernel: pair, traverse, output accumulator.  
   Invariant: lengths match.

6. `dot_product([1,2,3],[10,20,30]) -> 140`  
   Kernel: pair, multiply, reduce.

## Python transfer

Port drills 1, 5, and 6 from memory.

## C substrate probe

Implement `running_sum` with a fixed-size integer array and explicit loop index. Ask what `std::vector` hid and what Python hid.

---

# Day 2 — Mapping, Shape, Validation, and Lookup

Primary executable model:

```text
structured data
→ coordinate or key
→ mapped storage location
→ invariant check
```

## C++ drills

7. `flatten_2d([[1,2],[3,4]]) -> [1,2,3,4]` using nested loops only.

8. `flat_index_2d(shape=(2,3), row=1, col=2) -> 5`  
   Kernel: row-major index mapping.  
   Invariant: row and column stay in bounds.

9. `validate_shape(data=[1,2,3,4], shape=(2,2)) -> true`  
   Also test `(3,2)` as invalid.  
   Invariant: product of dimensions equals element count.

10. `reshape_metadata_only(data=[1,2,3,4], old=(2,2), new=(4,))`  
    Output: same data, new valid metadata.

11. `frequency_map(["a","b","a","c","b","a"]) -> {"a":3,"b":2,"c":1}`  
    Kernel: hashmap lookup, accumulator per key.

12. `group_by_first_letter(["cat","car","dog","door"])`  
    Output: `{"c":["cat","car"], "d":["dog","door"]}`.

## Python transfer

Port drills 8, 9, and 11.

## C substrate probe

Implement `flat_index_2d` over a fixed-size flat array with explicit bounds and one integer offset.

---

# Day 3 — Composition, Matrix Kernels, and Tooling Transfer

Primary executable model:

```text
small transformations
→ compose into larger behavior
→ enforce invariants at boundaries
```

## C++ drills

13. `matrix_add([[1,2],[3,4]], [[10,20],[30,40]]) -> [[11,22],[33,44]]`

14. `transpose_2d([[1,2,3],[4,5,6]]) -> [[1,4],[2,5],[3,6]]`

15. `matrix_multiply([[1,2],[3,4]], [[5,6],[7,8]]) -> [[19,22],[43,50]]`  
    Kernel: nested loops and dot-product accumulation.  
    Invariant: columns of A equal rows of B.

16. `config_parser(["host=localhost","port=8000","debug=true"])`  
    Reject missing key, empty key, duplicate key, malformed line, and empty lines.

## Python transfer

Port drills 15 and 16.

## C substrate probe

Implement matrix addition over flat arrays. Ask where the 2D-to-1D mapping occurs.

---

# Day 4 — Tiny Tensor v0

## State

```text
flat data
shape metadata
```

## Invariants

```text
product(shape) == data.size()
dimensions are non-negative
indices stay within bounds
elementwise operations require equal shapes
matrix multiplication requires compatible inner dimensions
```

## C++ drills

17. Tensor constructor from already-flat input: `Tensor({1,2,3,4}, {2,2})`.

18. Tensor 2D indexing: `tensor.at(1,0) == 3`.

19. Tensor elementwise addition.

20. Tensor reshape: data stays unchanged, metadata changes.

21. Tensor matrix multiplication by reusing the Day 3 kernel.

## Python transfer

Write a minimal Python `Tensor` class from memory after the C++ model works. Compare what stayed identical, what types disappeared, what memory behavior became implicit, and what syntax became shorter.

---

# Saturday, June 6 — Blank-Page Proof Run

Without notes, implement:

```text
running_sum
elementwise_add
dot_product
flat_index_2d
validate_shape
matrix_multiply
minimal Tensor constructor
Tensor.at(row, col)
```

Then do one tooling simulation:

```text
Issue: CLI config parser crashes on empty lines.
Required:
1. write failing test
2. identify violated invariant
3. make smallest patch
4. run tests
5. write focused commit message
```

## Exit Criteria

You are ready to move deeper when you can:

```text
explain state without hand-waving
trace loops manually
derive accumulator patterns
distinguish data from metadata
map 2D coordinates into flat memory
implement matrix multiplication from dot products
write and enforce invariants
port a kernel between C++ and Python
```

---

# Rust Parking Lot

Do not begin Rust during this sprint. After the proof run, revisit the same drills in Rust to make ownership, borrowing, mutation, slices, vectors, and explicit error handling concrete.
