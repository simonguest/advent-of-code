import * as fs from "fs";
import { parse } from "csv-parse";

type Range = {
  low: number;
  high: number;
};

type Section = {
  r1: Range;
  r2: Range;
};

const getOverlaps = (s: Section) => {
  let hashMap = new Map();
  for (let i = s.r1.low; i <= s.r1.high; i++) {
    hashMap.set(i, (hashMap.get(i) || 0) + 1);
  }
  for (let i = s.r2.low; i <= s.r2.high; i++) {
    hashMap.set(i, (hashMap.get(i) || 0) + 1);
  }
  let overlaps = 0;
  hashMap.forEach((v) => {
    if (v == 2) overlaps += 1;
  });
  return overlaps;
};

const hasFullOverlap = (s: Section) => {
  let overlaps = getOverlaps(s);
  return overlaps === Math.min(s.r1.high - s.r1.low + 1, s.r2.high - s.r2.low + 1);
};

const hasPartialOverlap = (section: Section) => {
  let overlaps = getOverlaps(section);
  return overlaps > 0;
};

const createSection = (col1: string, col2: string) => {
  return {
    r1: { low: parseInt(col1.split("-")[0]), high: parseInt(col1.split("-")[1]) },
    r2: { low: parseInt(col2.split("-")[0]), high: parseInt(col2.split("-")[1]) },
  };
};

const run = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  parse(
    data,
    {
      delimiter: ",",
    },
    (error, rows: String[]) => {
      if (error) console.error(error);
      let pairs: number = 0;
      rows.forEach((r) => {
        let section = createSection(r[0], r[1]);
        if (hasFullOverlap(section)) pairs++;
      });
      console.log(pairs);
    }
  );
};

const run2 = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  parse(
    data,
    {
      delimiter: ",",
    },
    (error, rows: String[]) => {
      if (error) console.error(error);
      let pairs: number = 0;
      rows.forEach((r) => {
        let section = createSection(r[0], r[1]);
        if (hasPartialOverlap(section)) pairs++;
      });
      console.log(pairs);
    }
  );
};
run2("04-data.csv");
