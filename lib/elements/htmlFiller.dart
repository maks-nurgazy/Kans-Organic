import 'package:flutter/cupertino.dart';

class HtmlFiller {
  static final String host = 'http://localhost:64033';
  static void renderKatexHTML(context, body, Function callback){
    callback("""
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html lang="en">
          <head>
            <meta http-equiv="content-type" content="text/html; charset=utf-8"> 
            <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body>
        $body
        <link rel="stylesheet" href="$host/katex/katex.css">
        <style>
          body {
            font-size: 16px;
            line-height: 30px;
          }
          p {
            margin: 13px 0;
            line-height: 30px;
          }
          
          .red {
            color: red;
          }
          
          .bold {
            font-weight: bold;
          }
          
          table.formula {
            margin: 0;
            width: 100%;
          }
          
          table.formula td:nth-child(2) {
            padding-left: 10px;
            text-align: right;
            font-weight: bold;
          }
          
          .l-example {
            font-size: 17px;
            line-height: 50px;
            margin: 15px 0
          }
          
          .m-example {
            font-size: 17px;
            line-height: 50px;
          }
          
          .m-1 {
            margin: 10px 0;
          }
          
          .mb-2 {
            margin-bottom: 40px
          }
          
          .center {
            text-align: center;
          }
          
          .f-num {
            margin-left: 20px;
            margin-right: 20px;
          }
          
          ul {
            padding: 0 25px;
            margin: 0;
          }
          ul li {
            margin: 0;
          }
          
          ol {
            padding-left: 27px; 
          }
          
          ol li {
            margin-bottom: 7px;
          }
          
          ol li .num {
            font-weight: bold;
          }
          
          h3 {
            margin: 5px 0;
          }
          .mt-0 {
            margin-top: 0;
          }
          .mt-1 {
            margin-top: 5px;
          }
          .mt-2 {
            margin-top: 15px;
          }
          .mt-3 {
            margin-top: 25px;
          }
          
          .mt-4 {
            margin-top: 30px;
          }
          .mb-0 {
            margin-bottom: 0;
          }
          .my-1 {
             margin-top: 5px;
             margin-bottom: 5px;
          }
          .l-example.katex-my-1 .katex-html .base {
            margin-top: 2px;
            margin-bottom: 2px;
          }
          .my-2 {
            margin: 15px 0;
          }
          .l-example.katex-my-2 .katex-html .base {
            margin-top: 5px;
            margin-bottom: 5px;
          }
        </style>
        <script  src="$host/katex/katex.js"></script>
        <script src="$host/katex/renderer.js"></script>
        <script>
        window.WebFontConfig = {
            custom: {
                families: ['KaTeX_AMS', 'KaTeX_Caligraphic:n4,n7', 'KaTeX_Fraktur:n4,n7',
                    'KaTeX_Main:n4,n7,i4,i7', 'KaTeX_Math:i4,i7', 'KaTeX_Script',
                    'KaTeX_SansSerif:n4,n7,i4', 'KaTeX_Size1', 'KaTeX_Size2', 'KaTeX_Size3',
                    'KaTeX_Size4', 'KaTeX_Typewriter'],
            },
        };
          renderMathInElement(
              document.body,
              {
                  delimiters: [
                      {left: "\$\$", right: "\$\$", display: true},
                      {left: "\$", right: "\$", display: false},
                      {left: "\\\\(", right: "\\\\)", display: false}
                  ]
              }
          );
        </script>
        </body>
      </html>
    """);
  }



  static void renderQuizHTML(context, questions, Function callback){
    callback("""
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html lang="en">
          <head>
            <meta http-equiv="content-type" content="text/html; charset=utf-8"> 
            <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body>
        <div class="blank-quiz single-question">
          <div class="row clearfix">
            <div class="questionsNumber">Question: <span class="currentQuestion">-</span>/<span class="allQuestions">-</span></div>
          </div>
          <div class="question-container"> 
            
          </div>
        </div>
        
        <div class="navigation">
            <button class="navigation-button" id="prev-button"><i class="prev-icon"></i> <span>Prev.</span></button>
          <button class="navigation-button" id="next-button"><span>Next</span> <i class="next-icon"></i></button>
        </div>
        
        <div class="finished-screen">
          <div class="title">
            Quiz Finished
          </div> 
          <div class="result-comment">
            Your result is
          </div>
          
          <div class="result-numbers">
            <span class="from">-</span>/<span class="to">-</span>
          </div>
          
          <div class="review-container">
            <div class="review-button-container">
              <button class="review-button">Review</button>
            </div>
            <div class="review-questions-container">
              <div class="q-title">Review</div>
              <div class="all-questions"></div>
            </div>
          </div>
          
        </div>
        
        <div class="" id="blank-question">
          <div class="questionTitle">
            
          </div>
          <div class="questionChoises">
            
          </div>
          
          <div class="answer-container">
            <div class="correct-anwer">Your answer is correct.</div>
            <div class="incorrect-anwer">
              <div class="answer-comment">
                Your answer is incorrect.
              </div>
              <div class="right-answer-comment">
                <div class="">The right answer is:</div>
                <div class="real-answer">
                  
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="questionChoise" id="blank-choise">
          <div class="choise-icon-container">
            <div class="choise-icon"></div>
          </div>
          <div class="choise-letter"></div>
          <div class="choise-answer">
            
          </div>
        </div>
       
        <style>
          .blank-quiz {
            padding: 10px;
          }
          
          .questionsNumber {
            float: right;
            border: 1px solid rgb(55, 137, 253);
            border-radius: 5px;
            padding: 5px 11px;
            color: rgb(55, 137, 253);
            font-size: 22px;
          
            -webkit-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            -moz-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
          }
          
          .questionTitle {
            font-size: 19px;
            padding: 8px;
            margin: 15px 0;
          }
          
          .questionChoise {
            border: none;
            cursor: pointer;
            border-radius: 5px;
            padding: 8px 12px;
            -webkit-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            -moz-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            position: relative;
          }
          
          .questionChoise:not(:last-of-type) {
            margin-bottom: 8px;
          }
          
          .questionChoise > .choise-icon {
            width: 20px;
            height: 20px;
            display: inline-block;
            position: relative;
            
          }
          
          .questionChoise > .choise-letter {
            margin-left: 25px;
            width: 15px;
            display: inline-block;
            vertical-align: top;
          }
          
          .questionChoise > .choise-answer {
            width: calc(100% - 45px);
            display: inline-block;
          }
          .questionChoise .choise-icon-container {
            display: inline-block;
             height: calc(100% - 18px);
             position: absolute;
          }
          
          .questionChoise .choise-icon {
            position: relative;
            top: calc(50%);
            -ms-transform: translateY(-50%);
            transform: translateY(-50%);
            width: 18px;
            height: 18px;
            background: url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTEyIDUxMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPHBhdGggZD0iTTQzNy4wMTksNzQuOThDMzg4LjY2NywyNi42MjksMzI0LjM4LDAsMjU2LDBDMTg3LjYxOSwwLDEyMy4zMzEsMjYuNjI5LDc0Ljk4LDc0Ljk4QzI2LjYyOCwxMjMuMzMyLDAsMTg3LjYyLDAsMjU2DQoJCQlzMjYuNjI4LDEzMi42NjcsNzQuOTgsMTgxLjAxOUMxMjMuMzMyLDQ4NS4zNzEsMTg3LjYxOSw1MTIsMjU2LDUxMmM2OC4zOCwwLDEzMi42NjctMjYuNjI5LDE4MS4wMTktNzQuOTgxDQoJCQlDNDg1LjM3MSwzODguNjY3LDUxMiwzMjQuMzgsNTEyLDI1NlM0ODUuMzcxLDEyMy4zMzMsNDM3LjAxOSw3NC45OHogTTI1Niw0ODJDMTMxLjM4Myw0ODIsMzAsMzgwLjYxNywzMCwyNTZTMTMxLjM4MywzMCwyNTYsMzANCgkJCXMyMjYsMTAxLjM4MywyMjYsMjI2UzM4MC42MTcsNDgyLDI1Niw0ODJ6Ii8+DQo8L3N2Zz4NCg==");
            background-position: center;
          }
          
          .questionChoise.active .choise-icon {
            background: url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTEyIDUxMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGc+DQoJPGc+DQoJCTxwYXRoIGZpbGw9InJnYig1NSwgMTM3LCAyNTMpIiBkPSJNNDM3LjAxOSw3NC45OEMzODguNjY3LDI2LjYyOSwzMjQuMzgsMCwyNTYsMEMxODcuNjE5LDAsMTIzLjMzMSwyNi42MjksNzQuOTgsNzQuOThDMjYuNjI4LDEyMy4zMzIsMCwxODcuNjIsMCwyNTYNCgkJCXMyNi42MjgsMTMyLjY2Nyw3NC45OCwxODEuMDE5QzEyMy4zMzIsNDg1LjM3MSwxODcuNjE5LDUxMiwyNTYsNTEyYzY4LjM4LDAsMTMyLjY2Ny0yNi42MjksMTgxLjAxOS03NC45ODENCgkJCUM0ODUuMzcxLDM4OC42NjcsNTEyLDMyNC4zOCw1MTIsMjU2UzQ4NS4zNzEsMTIzLjMzMyw0MzcuMDE5LDc0Ljk4eiBNMjU2LDQ4MkMxMzEuMzgzLDQ4MiwzMCwzODAuNjE3LDMwLDI1NlMxMzEuMzgzLDMwLDI1NiwzMA0KCQkJczIyNiwxMDEuMzgzLDIyNiwyMjZTMzgwLjYxNyw0ODIsMjU2LDQ4MnoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCgk8Zz4NCgkJPHBhdGggZmlsbD0icmdiKDU1LCAxMzcsIDI1MykiIGQ9Ik0zNzguMzA1LDE3My44NTljLTUuODU3LTUuODU2LTE1LjM1NS01Ljg1Ni0yMS4yMTIsMC4wMDFMMjI0LjYzNCwzMDYuMzE5bC02OS43MjctNjkuNzI3DQoJCQljLTUuODU3LTUuODU3LTE1LjM1NS01Ljg1Ny0yMS4yMTMsMGMtNS44NTgsNS44NTctNS44NTgsMTUuMzU1LDAsMjEuMjEzbDgwLjMzMyw4MC4zMzNjMi45MjksMi45MjksNi43NjgsNC4zOTMsMTAuNjA2LDQuMzkzDQoJCQljMy44MzgsMCw3LjY3OC0xLjQ2NSwxMC42MDYtNC4zOTNsMTQzLjA2Ni0xNDMuMDY2QzM4NC4xNjMsMTg5LjIxNSwzODQuMTYzLDE3OS43MTcsMzc4LjMwNSwxNzMuODU5eiIvPg0KCTwvZz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjwvc3ZnPg0K");
          }
          
          .questionChoise.active .choise-letter, .questionChoise.active .choise-answer {
            color: rgb(55, 137, 253);
          }
          
          .clearfix::after {
            content: "";
            clear: both;
            display: table;
          }
          
          html,
          body {
            padding: 0;
            margin: 0
          }
          
          
          body {
            width: calc(100vw);
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
          }
          
          .navigation {
            width: 100%;
            background: white;
            position: fixed;
            bottom: 0;
          }
          
          .navigation-button {
            border: none;
            border-radius: 5px;
            padding: 8px 14px;
            background: rgb(55, 137, 253);
            color: white;
            font-size: 22px;
            margin: 10px 25px 20px 25px;
            -webkit-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            -moz-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
          }
          
          .navigation-button.disabled {
            background: rgb(210, 210, 210);
          }
          
          .navigation-button {
            cursor: pointer;
          }
          
          .navigation-button:last-of-type {
            float:right;
          }
          i.prev-icon {
              background: url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgdmlld0JveD0iMCAwIDQ5Mi4wMDQgNDkyLjAwNCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDkyLjAwNCA0OTIuMDA0OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8Zz4NCgk8Zz4NCgkJPHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0zODIuNjc4LDIyNi44MDRMMTYzLjczLDcuODZDMTU4LjY2NiwyLjc5MiwxNTEuOTA2LDAsMTQ0LjY5OCwwcy0xMy45NjgsMi43OTItMTkuMDMyLDcuODZsLTE2LjEyNCwxNi4xMg0KCQkJYy0xMC40OTIsMTAuNTA0LTEwLjQ5MiwyNy41NzYsMCwzOC4wNjRMMjkzLjM5OCwyNDUuOWwtMTg0LjA2LDE4NC4wNmMtNS4wNjQsNS4wNjgtNy44NiwxMS44MjQtNy44NiwxOS4wMjgNCgkJCWMwLDcuMjEyLDIuNzk2LDEzLjk2OCw3Ljg2LDE5LjA0bDE2LjEyNCwxNi4xMTZjNS4wNjgsNS4wNjgsMTEuODI0LDcuODYsMTkuMDMyLDcuODZzMTMuOTY4LTIuNzkyLDE5LjAzMi03Ljg2TDM4Mi42NzgsMjY1DQoJCQljNS4wNzYtNS4wODQsNy44NjQtMTEuODcyLDcuODQ4LTE5LjA4OEMzOTAuNTQyLDIzOC42NjgsMzg3Ljc1NCwyMzEuODg0LDM4Mi42NzgsMjI2LjgwNHoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==");
            transform: rotate(180deg);
              width: 13px;
              height: 13px;
              display: inline-flex;
            margin-left: -4px;
              margin-bottom: -1px;
            color: white;
          }
          
          i.next-icon {
              background: url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgdmlld0JveD0iMCAwIDQ5Mi4wMDQgNDkyLjAwNCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDkyLjAwNCA0OTIuMDA0OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8Zz4NCgk8Zz4NCgkJPHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0zODIuNjc4LDIyNi44MDRMMTYzLjczLDcuODZDMTU4LjY2NiwyLjc5MiwxNTEuOTA2LDAsMTQ0LjY5OCwwcy0xMy45NjgsMi43OTItMTkuMDMyLDcuODZsLTE2LjEyNCwxNi4xMg0KCQkJYy0xMC40OTIsMTAuNTA0LTEwLjQ5MiwyNy41NzYsMCwzOC4wNjRMMjkzLjM5OCwyNDUuOWwtMTg0LjA2LDE4NC4wNmMtNS4wNjQsNS4wNjgtNy44NiwxMS44MjQtNy44NiwxOS4wMjgNCgkJCWMwLDcuMjEyLDIuNzk2LDEzLjk2OCw3Ljg2LDE5LjA0bDE2LjEyNCwxNi4xMTZjNS4wNjgsNS4wNjgsMTEuODI0LDcuODYsMTkuMDMyLDcuODZzMTMuOTY4LTIuNzkyLDE5LjAzMi03Ljg2TDM4Mi42NzgsMjY1DQoJCQljNS4wNzYtNS4wODQsNy44NjQtMTEuODcyLDcuODQ4LTE5LjA4OEMzOTAuNTQyLDIzOC42NjgsMzg3Ljc1NCwyMzEuODg0LDM4Mi42NzgsMjI2LjgwNHoiLz4NCgk8L2c+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==");
              width: 13px;
              height: 13px;
              display: inline-flex;
            margin-right: -4px;
              margin-bottom: -1px;
            color: white;
          }
          
          button:focus {outline:0;}
          
          .single-question::after {
            height: 66px;
            content: '';
            display: block;
          }
          
          #blank-question {
            display: none;
          }
          
          #blank-choise {
            display: none;
          }
          
          .correct-anwer {
            color: green;
            font-size: 18px;
            padding: 12px 5px;
            text-align: center;
          }
          
          .incorrect-anwer .answer-comment {
            color: #d50000;
            font-size: 18px;
            padding: 12px 5px;
            text-align: center;
          }
          
          .incorrect-anwer .right-answer-comment {
            color: #121212;
            font-size: 18px;
            padding: 0 5px 12px 5px;
          }
          
          .incorrect-anwer .real-answer {
            font-size: 17px;
            padding: 5px 3px;
          }
          
          .finished-screen {
            padding-top: 40px;
            display: none;
          }
          
          .finished-screen.shown {
            display: block;
          }
          
          .finished-screen .title {
            color: rgb(55, 137, 253);
            font-size: 40px;
            font-weight: 450;
            margin: 15px;
            text-align: center;
          }
          
          .finished-screen .result-comment {
            color: rgb(55, 137, 253);
            font-size: 25px;
            font-weight: 450;
            margin: 15px;
            text-align: center;
          }
          
          .result-numbers {
            color: rgb(55, 137, 253);
            font-size: 50px;
            margin: 15px;
            text-align: center;
          }
          
          .finished-screen .review-container:not(.open) .review-button-container {
            position: absolute;
            left: 50%;
            bottom: 40px;
          }
          .finished-screen .review-container:not(.open) .review-button {
            position: relative;
            border: none;
            color: #fff;
            background: rgb(55, 137, 253);
            -webkit-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            -moz-box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 8px 0px rgba(0, 0, 0, 0.4);
            padding: 12px 40px;
            border-radius: 8px;
            font-size: 25px;
            left: -50%;
            cursor: pointer;
          }
          
          .review-questions-container .q-title {
            color: #121212;
            font-size: 22px;
            margin: 0 5px 15px 20px;
          }
          
          .review-questions-container .all-questions {
            margin: 5px 15px;
          }
          
          .highlighted {
            color: rgb(55, 100, 253);
          }
        </style>
        
        <script src="$host/jquery/jquery.min.js"></script>
        <script src="$host/katex/katex.js"></script>
        <link rel="stylesheet" href="$host/katex/katex.css">
        <script src="$host/katex/renderer.js"></script>
        <script>
          \$(function(){
            let questions = $questions;
            let isFinished = false;
            let isReview = false;
            let currentQuestion = 0;
            let answers = {};
            
            let prevButtonElement = \$('#prev-button');
            let nextButtonElement = \$('#next-button');
            
            \$('.result-numbers > .to').text(questions.length);
            
            prevButtonElement.addClass('disabled');
            
           
            
            prevButtonElement.click(function(){
              if (currentQuestion > 0) {
                currentQuestion--;
              }
              if (currentQuestion == 0){
                prevButtonElement.addClass('disabled');
              }
               nextButtonElement.children('span').text('Next');
              refreshScreen();
            });
            
            nextButtonElement.click(function(){
              if (currentQuestion + 1 < questions.length){
                currentQuestion++;
                prevButtonElement.removeClass('disabled');
                
                if (currentQuestion + 1 == questions.length) {
                  nextButtonElement.children('span').text('Finish');
                }
              } else {
                isFinished = true;
              }
              refreshScreen();
            });
            
            let questionContainer = \$('.question-container');
            let blankQuestion = \$("#blank-question");
            let blankChoise = \$("#blank-choise");
            
            let questionsNumberElement = \$('.questionsNumber');
            let currentQuestionNumberElement = questionsNumberElement.children('.currentQuestion');
            let allQuestionsNumberElement = questionsNumberElement.children('.allQuestions');

            let alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
            
            function createQuestion(questionId, choosen = null, showAnswer = false){
              let question = questions[questionId];
              
              let newQuestionElement = blankQuestion.clone();
              newQuestionElement.attr('question-id', questionId);
              
              newQuestionElement.children('.questionTitle').html(question.title);
              
              let choisesContainerElement = newQuestionElement.find('.questionChoises');
              
              \$.each(question['variants'], function( index, value ) {
                let newBlankChoise = blankChoise.clone();
                newBlankChoise.removeAttr('id');
                
                newBlankChoise.attr('choise-id', index);
                
                if (choosen !== null && choosen == index){
                  newBlankChoise.addClass('active');
                }
                newBlankChoise.find('.choise-letter').html(alphabet[index] + '.');
                newBlankChoise.find('.choise-answer').html(value);
                
                choisesContainerElement.append(newBlankChoise);
              });
              
              let answerContainerElement = newQuestionElement.find('.answer-container');
              if (showAnswer){
                if (choosen !== null){
                  if (choosen == question['answer']){
                    answerContainerElement.find('.incorrect-anwer').hide();
                  } else {
                    answerContainerElement.find('.correct-anwer').hide();
                    
                    let realAnswerElement = answerContainerElement.find('.real-answer');
                    realAnswerElement.html(question['variants'][question['answer']]);
                  }
                } else { 
                  answerContainerElement.find('.correct-anwer').hide();
                  
                  answerContainerElement.find('.right-answer-comment').hide();
                }
              } else {
                answerContainerElement.hide();
              }
              newQuestionElement.removeAttr('id');
              return newQuestionElement;
            }
            
            function refreshScreen(){
              if (isFinished){
                \$('.blank-quiz').hide();
                \$('.navigation').hide();
                \$('.finished-screen').addClass('shown');
                if (isReview){
                  \$('.review-button-container').hide();
                  \$('.review-questions-container').show();
                  
                  let allQuestionsContainer = \$('.all-questions');
                  allQuestionsContainer.children().remove();
                  \$.each(questions, function( index, question ) {
                    allQuestionsContainer.append(createQuestion(index, answers[index] === undefined ? null : answers[index], true));
                  });
                } else {
                  \$('.review-button-container').show();
                  \$('.review-questions-container').hide();
                }
              } else {
                 questionContainer.html(createQuestion(currentQuestion, answers[currentQuestion] === undefined ? null : answers[currentQuestion]));
                currentQuestionNumberElement.html(currentQuestion + 1);
                allQuestionsNumberElement.html(questions.length);
              }
              
              let correctQuestionsNumber = 0;
              \$.each(questions, function( index, value ) {
                if (value['answer'] == answers[index]){
                  correctQuestionsNumber++;
                }
              });
              
              \$('.result-numbers > .from').text(correctQuestionsNumber);
              
              renderMathInElement(
                  document.body,
                  {
                      delimiters: [
                          {left: "\$\$", right: "\$\$", display: true},
                          {left: "\$", right: "\$", display: false},
                          {left: "\\\\(", right: "\\\\)", display: false}
                      ]
                  }
              );
            }
            
            \$(document).on('click', '.questionChoise', function(){
              let self = \$(this);
              if (self.closest('.review-questions-container').length == 0){
                let questionId = parseInt(self.closest('[question-id]').attr('question-id'));
                let choiseId = parseInt(self.closest('[choise-id]').attr('choise-id'));
                
                answers[questionId] = choiseId;
                refreshScreen();
              }
            });
            
            \$('.review-button').click(function(){
              isReview = true;
              refreshScreen();
            });
                         
            refreshScreen();
          });
        window.WebFontConfig = {
            custom: {
                families: ['KaTeX_AMS', 'KaTeX_Caligraphic:n4,n7', 'KaTeX_Fraktur:n4,n7',
                    'KaTeX_Main:n4,n7,i4,i7', 'KaTeX_Math:i4,i7', 'KaTeX_Script',
                    'KaTeX_SansSerif:n4,n7,i4', 'KaTeX_Size1', 'KaTeX_Size2', 'KaTeX_Size3',
                    'KaTeX_Size4', 'KaTeX_Typewriter'],
            },
        };
        </script>
        </body>
      </html>
    """);
  }
}