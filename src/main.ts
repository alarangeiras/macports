import { exec } from "child_process";
import { promisify } from "util";
import Table from 'cli-table';

async function main() {
    const result = await promisify(exec)("sudo lsof -iTCP -sTCP:LISTEN -n -P");
    const rawResult = result.stdout;
    const lines = rawResult.split("\n");
    const table = new Table();
    for (const line of lines) {
        const parts = line.split(/\s+/);
        if (parts[0] === '') {
            continue;
        }
        table.push(parts);
    }
    console.log(table.toString());
}

main();