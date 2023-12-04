import re


def is_part_number(matrix, number):
    neighbours = [matrix[number['r'] - 1][number['c'] - 1: number['c'] + len(str(number['n'])) + 1],
                  matrix[number['r'] + 1][number['c'] - 1: number['c'] + len(str(number['n'])) + 1],
                  matrix[number['r']][number['c'] - 1],
                  matrix[number['r']][number['c'] + len(str(number['n']))]]
    symbols = ''.join(neighbours).replace('.', '')
    return len(symbols) > 0


def find_numbers(matrix):
    numbers = []
    for row in matrix:
        pattern = r'\d+'
        matches = re.finditer(pattern, row)
        numbers_in_row = [(int(match.group()), match.start()) for match in matches]
        for number in numbers_in_row:
            numbers.append({'n': number[0], 'c': number[1], 'r': matrix.index(row)})
    return numbers


def create_array(filename):
    f = open(filename, 'r')
    matrix = []
    for line in f:
        if not matrix:
            matrix.append('.' * len(line))
        matrix.append('.' + line.strip() + '.')
    matrix.append('.' * len(line))
    return matrix


matrix = create_array('03-data.txt')
total = 0
for number in find_numbers(matrix):
    if is_part_number(matrix, number):
        total += int(number['n'])
print(total)