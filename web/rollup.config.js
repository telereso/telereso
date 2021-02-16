import commonjs from "@rollup/plugin-commonjs";
import resolve from "@rollup/plugin-node-resolve";
import peerDepsExternal from "rollup-plugin-peer-deps-external";
import babel from 'rollup-plugin-babel';
import typescript from "rollup-plugin-typescript2";

import packageJson from "./package.json";

export default {
    input: "./src/index.ts",
    output: [
        {
            file: packageJson.main,
            format: "cjs",
            sourcemap: true
        },
        {
            file: packageJson.module,
            format: "esm",
            sourcemap: true
        }
    ],
    plugins: [peerDepsExternal(), resolve(), babel({
        exclude: 'node_modules/**',
        presets: ['@babel/env', '@babel/preset-react'],
        plugins: [
            '@babel/plugin-proposal-class-properties',
            '@babel/plugin-transform-arrow-functions',
        ]
    }),commonjs(), typescript()]
};
