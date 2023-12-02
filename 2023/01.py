strings = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]


def calc_number(line) -> int:
    found_numbers = []
    for index, char in enumerate(line):
        # check if char is a number
        if char.isdigit():
            found_numbers.append(int(char))
        # check if one of the words in strings is at the current index
        for word in strings:
            if line[index:].startswith(word):
                found_numbers.append(strings.index(word) + 1)
    return (int(found_numbers[0]) * 10) + int(found_numbers[-1])


f = open('01-data.txt', 'r')
total = 0
for line in f:
    total += calc_number(line)
print(total)
