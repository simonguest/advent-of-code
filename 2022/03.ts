import * as fs from "fs";
import { parse } from "csv-parse";

type Rucksack = {
  contents: string;
  left: string;
  right: string;
};

const convertToPriority = (o: string) => {
  let charCode = o.charCodeAt(0);
  if (charCode >= 97) return charCode - 96;
  return charCode - 65 + 27;
};

const findOverlap = (r: Rucksack) => {
  return r.left.split("").find((l) => {
    if (r.right.indexOf(l) > -1) return l;
  });
};

const splitRucksack = (r: Rucksack) => {
  r.left = r.contents.substring(0, r.contents.length / 2);
  r.right = r.contents.substring(r.contents.length / 2, r.contents.length);
  return r;
};

const run = async () => {
  const data = fs.readFileSync("03-data.csv", { encoding: "utf-8" });
  parse(
    data,
    {
      columns: ["contents"],
    },
    (error, rucksacks: Rucksack[]) => {
      let total: number = 0;
      rucksacks.forEach((r) => {
        let s = splitRucksack(r);
        let o = findOverlap(s);
        let p = convertToPriority(o);
        total += p;
      });
      console.log(total);
    }
  );
};

const splitIntoGroups = function* (rucksacks: Rucksack[], size: number) {
  for (let i = 0; i < rucksacks.length; i += size) {
    yield rucksacks.slice(i, i + size);
  }
};

const findCommon = (rucksacks: Rucksack[]) => {
  return rucksacks[0].contents.split('').find(l => {
    if (rucksacks[1].contents.indexOf(l) > -1 && rucksacks[2].contents.indexOf(l) > -1) return l;
  });
}

const run2 = async () => {
  const data = fs.readFileSync("03-data.csv", { encoding: "utf-8" });
  parse(
    data,
    {
      columns: ["contents"],
    },
    (error, rucksacks: Rucksack[]) => {
      let total: number = 0;
      const gen = splitIntoGroups(rucksacks, 3);
      let group = gen.next();
      while (!group.done) {
        if (group.value) {
          let c = findCommon(group.value);
          total += convertToPriority(c);
        }
        group = gen.next();
      }
      console.log(total);
    }
  );
};
run2();
