import * as fs from "fs";

type Stack = {
  data: string[];
};

type Move = {
  amount: number;
  from: number;
  to: number;
};

const buildStacks = (data: string) => {
  let lines = data.split("\n");
  let numberOfStacks = (lines[0].length + 1) / 3 - 1;
  let stacks: Stack[] = new Array<Stack>(numberOfStacks).fill(null).map(() => ({ data: [] }));
  lines.find((line) => {
    if (line.startsWith("move")) return;
    for (let col = 1; col <= numberOfStacks; col++) {
      let char = line[col * 4 - 3];
      if (char) {
        if (char.match(/[A-Z]/i)) stacks[col - 1].data.push(char);
      }
    }
  });
  return stacks;
};

const move9000 = (stacks: Stack[], move: Move) => {
  Array.from({ length: move.amount }, () => {
    let charToMove: string = stacks[move.from - 1].data.slice(0, 1)[0];
    stacks[move.from - 1].data = stacks[move.from - 1].data.slice(1, stacks[move.from - 1].data.length);
    stacks[move.to - 1].data.unshift(charToMove);
  });
  return stacks;
};

const move9001 = (stacks: Stack[], move: Move) => {
  let charsToMove: string[] = stacks[move.from - 1].data.slice(0, move.amount);
  stacks[move.from - 1].data = stacks[move.from - 1].data.slice(move.amount, stacks[move.from - 1].data.length);
  stacks[move.to - 1].data = [...charsToMove, ...stacks[move.to-1].data]
  return stacks;
};

const getMoves = (data: string) => {
  let moves: Move[] = [];
  let lines = data.split("\n");
  lines.forEach((line) => {
    let match = line.match(/move ([0-9]*) from ([0-9]*) to ([0-9]*)/);
    if (match) {
      moves.push({ amount: parseInt(match[1]), from: parseInt(match[2]), to: parseInt(match[3]) });
    }
  });
  return moves;
};

const getTop = (stacks: Stack[]) => {
  let top: string = "";
  stacks.forEach((s) => {
    if (s.data.length > 0) {
      top += s.data.slice(0, 1)[0];
    }
  });
  return top;
};

const run = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  let stacks = buildStacks(data);
  let moves = getMoves(data);
  moves.forEach((m) => {
    stacks = move9000(stacks, m);
  });
  console.log(getTop(stacks));
};

const run2 = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  let stacks = buildStacks(data);
  let moves = getMoves(data);
  moves.forEach((m) => {
    stacks = move9001(stacks, m);
  });
  console.log(getTop(stacks));
};

run2("05-data.txt");