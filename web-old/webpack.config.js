const path = require('path')
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');

module.exports = {
    entry: './src/index.ts',
    output: {
        path: path.resolve(__dirname, './dist'),
        filename: 'bundle.js',
        libraryTarget: 'umd',
        library: "telereso-web",
        umdNamedDefine: true,
        libraryExport: 'default'

    },
    module: {
        rules: [
            {
                test: /\.(js|ts|tsx)x?$/,
                exclude: /node_modules/,
                use: [
                    {
                        loader: "babel-loader",
                        options: {
                            cacheDirectory: true,
                            presets: [
                                ["@babel/preset-env", { targets: { node: "8" } }],
                                [
                                    "@babel/preset-typescript",
                                    { isTSX: true, allExtensions: true }
                                ]
                            ]
                        }
                    }
                ],
            },
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.jsx', '.js'],
    },
    devServer: {
        contentBase: path.resolve(__dirname, './dist')
    }
}
