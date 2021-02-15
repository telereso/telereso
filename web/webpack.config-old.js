const path = require( 'path' );
const babelLoaderOptions = {
    presets: [
        '@babel/preset-typescript',
        [
            '@babel/preset-env',
            {
                loose: true,
                // debug: true,
                modules: 'auto',
                spec: true,
                useBuiltIns: 'usage',
                corejs: 3,
                targets: {
                    browsers: ['last 2 versions'],
                    // esmodules: true,
                },
            },
        ],
        ["@babel/preset-react", {
            "runtime": "automatic"
        }],
    ],
    plugins: [
        ['@babel/plugin-transform-runtime', {
            corejs: 3,
            helpers: true,
            regenerator: false,
            absoluteRuntime: false,
            useESModules: true,
        }],
        '@babel/plugin-proposal-export-default-from',
        '@babel/plugin-proposal-export-namespace-from',
        '@babel/plugin-syntax-dynamic-import',
        'lodash',
        '@babel/plugin-proposal-class-properties',
        '@babel/plugin-transform-arrow-functions',
    ],
};
module.exports = {
    context: __dirname,
    entry: './src/index.ts',
    output: {
        path: path.resolve( __dirname, 'dist' ),
        filename: 'bundle.js',
    },
    devServer: {
        port: 9898,
        historyApiFallback: true
    },
    module: {
        rules: [
            {
                test: /\.(js|jsx)$/,
                exclude: /node_modules(?!(\/|\\)vast-client)/,
                loader: 'babel-loader',
                options: babelLoaderOptions,
            }
        ]
    }
};
