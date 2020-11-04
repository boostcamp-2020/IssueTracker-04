const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  // entry: 웹팩에게 어플리케이션이 어디서 시작하고 어디서부터 파일들을 묶을건지 시작점을 정해준다.
  entry: ['babel-polyfill', './src/index.js'],
  // 현재 개발 모드에서 작업 중임을 알려줌.
  mode: 'development',
  // export한 JS 모듈이 어떻게 변환되는지 정의한다. 방법은 rules에 정의한 대로 이루어진다.
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: '/node_modules/',
        loader: 'babel-loader',
        options: {
          presets: [
            // 배열로 선언하면 babel이 컴파일 할 대상 브라우저도 지정 가능
            [
              '@babel/preset-env',
              {
                targets: {
                  // 크롬 최종 버젼으로 부터 2개 버젼 https://github.com/browserslist/browserslist#queries
                  browsers: ['last 2 chrome versions'],
                },
                debug: true,
              },
            ],
            '@babel/preset-react',
          ],
          plugins: ['@babel/plugin-proposal-class-properties'],
        },
      },
      {
        test: /\.(css|scss)$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(jpeg|jpg|JPG|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]',
        },
      },
    ],
  },
  // resolve: 웹팩이 해석할 확장자를 지정.
  resolve: {
    extensions: ['*', '.js', '.jsx'],
    alias: {
      '@components': path.resolve(__dirname, 'src/components'),
      '@views': path.resolve(__dirname, 'src/views'),
      '@assets': path.resolve(__dirname, 'src/assets'),
    },
  },
  // output: 번들링 된 결과물을 어디다 둘 것인지에 대한 설정이 가능.
  output: {
    path: path.resolve(__dirname, 'dist'),
    // 번들이 생기는 경로를 지정. webpack-dev-server도 이를 참조
    // publicPath: '/dist/',
    filename: 'bundle.js',
  },

  devtool: 'inline-source-map',

  // webpack-dev-server의 옵션을 설정
  devServer: {
    // 정적 파일 경로 설정
    contentBase: path.join(__dirname, 'dist'),
    port: 3000,
    // devserver 에서만 핫로딩 가능하게
    hotOnly: true,
    open: true,
    historyApiFallback: true,
    proxy: {
      '/api': 'http://localhost:5000',
    },
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      // 번들링된 JS를 주입하고 결과물을 옮길 대상이 되는 파일을 지정
      template: './public/index.html',
      filename: './index.html',
    }),
    new CleanWebpackPlugin(),
    new MiniCssExtractPlugin({ filename: 'app.css' }),
  ],
};
