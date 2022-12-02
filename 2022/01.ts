import * as fs from "fs";
import { parse } from "csv-parse";

const run = async () => {
  let elves: number[] = [];
  const data = fs.readFileSync("01-data.csv", { encoding: "utf-8" });
  let runningTotal = 0;
  for await (const calories of parse(data, { delimiter: "," })) {
    if (calories[0] === "") {
      elves.push(runningTotal);
      runningTotal = 0;
    } else {
      runningTotal += parseInt(calories[0]);
    }
  }
  elves = elves.sort((a, b) => {
    return b - a;
  });
  console.log(`Top Elf: ${elves[0]}`);
  console.log(`Top Three Total: ${elves.slice(0, 3).reduce((s, a) => s + a, 0)}`);
};
run();
