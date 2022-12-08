import * as fs from "fs";

type DataStream = {
  chars: Map<string, number>;
  frame: Array<string>;
};

const push = (stream: DataStream, char: string, frameLength: number) => {
  stream.frame.push(char);
  if (stream.frame.length > frameLength) stream.frame = stream.frame.slice(1, stream.frame.length);
  stream.chars.set(char, stream.chars.get(char) + 1 || 1);
  return stream;
};

const isFrameUnique = (stream: DataStream, frameLength: number) => {
  if (stream.frame.length < frameLength) return false;
  let frameMap = new Map<string, number>();
  stream.frame.forEach((c) => {
    frameMap.set(c, frameMap.get(c) + 1 || 1); 
  });
  return Array.from(frameMap.values()).length === frameLength;
};

const run = async (filename: string) => {
  const data = fs.readFileSync(filename, { encoding: "utf-8" });
  let stream = { chars: new Map(), frame: new Array<string>() };
  let found = false;
  let cursor = 0;
  do {
    cursor++;
    stream = push(stream, data[cursor -1], 14);
    if (isFrameUnique(stream, 14)) found = true;
  } while (found === false);
  console.log(cursor);
};
run("06-data.txt");
