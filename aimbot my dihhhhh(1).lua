{\rtf1\ansi\ansicpg1252\cocoartf2870
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fmodern\fcharset0 Courier;\f1\fmodern\fcharset0 Courier-Oblique;}
{\colortbl;\red255\green255\blue255;\red70\green137\blue204;\red12\green14\blue18;\red189\green198\blue208;
\red212\green212\blue212;\red194\green126\blue101;\red120\green129\blue140;\red167\green197\blue152;}
{\*\expandedcolortbl;;\cssrgb\c33725\c61176\c83922;\cssrgb\c5098\c6667\c9020;\cssrgb\c78824\c81961\c85098;
\cssrgb\c86275\c86275\c86275;\cssrgb\c80784\c56863\c47059;\cssrgb\c54510\c58039\c61961;\cssrgb\c70980\c80784\c65882;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 local\cf4 \strokec4  Players \cf5 \strokec5 =\cf4 \strokec4  game\cf5 \strokec5 :\cf4 \strokec4 GetService\cf5 \strokec5 (\cf6 \strokec6 "Players"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 local\cf4 \strokec4  RunService \cf5 \strokec5 =\cf4 \strokec4  game\cf5 \strokec5 :\cf4 \strokec4 GetService\cf5 \strokec5 (\cf6 \strokec6 "RunService"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 local\cf4 \strokec4  LocalPlayer \cf5 \strokec5 =\cf4 \strokec4  Players\cf5 \strokec5 .\cf4 \strokec4 LocalPlayer\cb1 \
\cf2 \cb3 \strokec2 local\cf4 \strokec4  Camera \cf5 \strokec5 =\cf4 \strokec4  workspace\cf5 \strokec5 .\cf4 \strokec4 CurrentCamera\cb1 \
\
\cf2 \cb3 \strokec2 local\cf4 \strokec4  Enabled \cf5 \strokec5 =\cf4 \strokec4  \cf2 \strokec2 false\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0

\f1\i \cf7 \cb3 \strokec7 -- Create mobile GUI
\f0\i0 \cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 local\cf4 \strokec4  ScreenGui \cf5 \strokec5 =\cf4 \strokec4  Instance\cf5 \strokec5 .\cf4 \strokec4 new\cf5 \strokec5 (\cf6 \strokec6 "ScreenGui"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3 ScreenGui\cf5 \strokec5 .\cf4 \strokec4 Name \cf5 \strokec5 =\cf4 \strokec4  \cf6 \strokec6 "MobileAimbot"\cf4 \cb1 \strokec4 \
\cb3 ScreenGui\cf5 \strokec5 .\cf4 \strokec4 ResetOnSpawn \cf5 \strokec5 =\cf4 \strokec4  \cf2 \strokec2 false\cf4 \cb1 \strokec4 \
\cb3 ScreenGui\cf5 \strokec5 .\cf4 \strokec4 Parent \cf5 \strokec5 =\cf4 \strokec4  LocalPlayer\cf5 \strokec5 :\cf4 \strokec4 WaitForChild\cf5 \strokec5 (\cf6 \strokec6 "PlayerGui"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 local\cf4 \strokec4  Button \cf5 \strokec5 =\cf4 \strokec4  Instance\cf5 \strokec5 .\cf4 \strokec4 new\cf5 \strokec5 (\cf6 \strokec6 "TextButton"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3 Button\cf5 \strokec5 .\cf4 \strokec4 Size \cf5 \strokec5 =\cf4 \strokec4  UDim2\cf5 \strokec5 .\cf4 \strokec4 new\cf5 \strokec5 (\cf8 \strokec8 0\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 130\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 0\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 50\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 Position \cf5 \strokec5 =\cf4 \strokec4  UDim2\cf5 \strokec5 .\cf4 \strokec4 new\cf5 \strokec5 (\cf8 \strokec8 0.75\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 0\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 0.7\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 0\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 BackgroundColor3 \cf5 \strokec5 =\cf4 \strokec4  Color3\cf5 \strokec5 .\cf4 \strokec4 fromRGB\cf5 \strokec5 (\cf8 \strokec8 200\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 40\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 40\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 TextColor3 \cf5 \strokec5 =\cf4 \strokec4  Color3\cf5 \strokec5 .\cf4 \strokec4 new\cf5 \strokec5 (\cf8 \strokec8 1\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 1\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 1\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 TextScaled \cf5 \strokec5 =\cf4 \strokec4  \cf2 \strokec2 true\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 Text \cf5 \strokec5 =\cf4 \strokec4  \cf6 \strokec6 "AIM: OFF"\cf4 \cb1 \strokec4 \
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 Parent \cf5 \strokec5 =\cf4 \strokec4  ScreenGui\cb1 \
\
\cb3 Button\cf5 \strokec5 .\cf4 \strokec4 MouseButton1Click\cf5 \strokec5 :\cf4 \strokec4 Connect\cf5 \strokec5 (\cf2 \strokec2 function\cf5 \strokec5 ()\cf4 \cb1 \strokec4 \
\cb3     Enabled \cf5 \strokec5 =\cf4 \strokec4  \cf2 \strokec2 not\cf4 \strokec4  Enabled\cb1 \
\
\cb3     \cf2 \strokec2 if\cf4 \strokec4  Enabled \cf2 \strokec2 then\cf4 \cb1 \strokec4 \
\cb3         Button\cf5 \strokec5 .\cf4 \strokec4 Text \cf5 \strokec5 =\cf4 \strokec4  \cf6 \strokec6 "AIM: ON"\cf4 \cb1 \strokec4 \
\cb3         Button\cf5 \strokec5 .\cf4 \strokec4 BackgroundColor3 \cf5 \strokec5 =\cf4 \strokec4  Color3\cf5 \strokec5 .\cf4 \strokec4 fromRGB\cf5 \strokec5 (\cf8 \strokec8 40\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 200\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 40\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3     \cf2 \strokec2 else\cf4 \cb1 \strokec4 \
\cb3         Button\cf5 \strokec5 .\cf4 \strokec4 Text \cf5 \strokec5 =\cf4 \strokec4  \cf6 \strokec6 "AIM: OFF"\cf4 \cb1 \strokec4 \
\cb3         Button\cf5 \strokec5 .\cf4 \strokec4 BackgroundColor3 \cf5 \strokec5 =\cf4 \strokec4  Color3\cf5 \strokec5 .\cf4 \strokec4 fromRGB\cf5 \strokec5 (\cf8 \strokec8 200\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 40\cf5 \strokec5 ,\cf4 \strokec4  \cf8 \strokec8 40\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3     \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 end\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf4 \cb3 RunService\cf5 \strokec5 .\cf4 \strokec4 RenderStepped\cf5 \strokec5 :\cf4 \strokec4 Connect\cf5 \strokec5 (\cf2 \strokec2 function\cf5 \strokec5 ()\cf4 \cb1 \strokec4 \
\cb3     \cf2 \strokec2 if\cf4 \strokec4  \cf2 \strokec2 not\cf4 \strokec4  Enabled \cf2 \strokec2 then\cf4 \strokec4  \cf2 \strokec2 return\cf4 \strokec4  \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 local\cf4 \strokec4  closestPlayer\cb1 \
\cb3     \cf2 \strokec2 local\cf4 \strokec4  shortestDistance \cf5 \strokec5 =\cf4 \strokec4  math\cf5 \strokec5 .\cf4 \strokec4 huge\cb1 \
\
\cb3     \cf2 \strokec2 for\cf4 \strokec4  _\cf5 \strokec5 ,\cf4 \strokec4  player \cf2 \strokec2 in\cf4 \strokec4  pairs\cf5 \strokec5 (\cf4 \strokec4 Players\cf5 \strokec5 :\cf4 \strokec4 GetPlayers\cf5 \strokec5 ())\cf4 \strokec4  \cf2 \strokec2 do\cf4 \cb1 \strokec4 \
\cb3         \cf2 \strokec2 if\cf4 \strokec4  player \cf5 \strokec5 ~=\cf4 \strokec4  LocalPlayer \cf2 \strokec2 and\cf4 \strokec4  player\cf5 \strokec5 .\cf4 \strokec4 Character \cf2 \strokec2 then\cf4 \cb1 \strokec4 \
\cb3             \cf2 \strokec2 local\cf4 \strokec4  head \cf5 \strokec5 =\cf4 \strokec4  player\cf5 \strokec5 .\cf4 \strokec4 Character\cf5 \strokec5 :\cf4 \strokec4 FindFirstChild\cf5 \strokec5 (\cf6 \strokec6 "Head"\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\
\cb3             \cf2 \strokec2 if\cf4 \strokec4  head \cf2 \strokec2 then\cf4 \cb1 \strokec4 \
\cb3                 \cf2 \strokec2 local\cf4 \strokec4  distance \cf5 \strokec5 =\cf4 \cb1 \strokec4 \
\cb3                     \cf5 \strokec5 (\cf4 \strokec4 head\cf5 \strokec5 .\cf4 \strokec4 Position \cf5 \strokec5 -\cf4 \strokec4  Camera\cf5 \strokec5 .\cf4 \strokec4 CFrame\cf5 \strokec5 .\cf4 \strokec4 Position\cf5 \strokec5 ).\cf4 \strokec4 Magnitude\cb1 \
\
\cb3                 \cf2 \strokec2 if\cf4 \strokec4  distance \cf5 \strokec5 <\cf4 \strokec4  shortestDistance \cf2 \strokec2 then\cf4 \cb1 \strokec4 \
\cb3                     shortestDistance \cf5 \strokec5 =\cf4 \strokec4  distance\cb1 \
\cb3                     closestPlayer \cf5 \strokec5 =\cf4 \strokec4  head\cb1 \
\cb3                 \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\cb3             \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\cb3         \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\cb3     \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 if\cf4 \strokec4  closestPlayer \cf2 \strokec2 then\cf4 \cb1 \strokec4 \
\cb3         Camera\cf5 \strokec5 .\cf4 \strokec4 CFrame \cf5 \strokec5 =\cf4 \strokec4  CFrame\cf5 \strokec5 .\cf4 \strokec4 lookAt\cf5 \strokec5 (\cf4 \cb1 \strokec4 \
\cb3             Camera\cf5 \strokec5 .\cf4 \strokec4 CFrame\cf5 \strokec5 .\cf4 \strokec4 Position\cf5 \strokec5 ,\cf4 \cb1 \strokec4 \
\cb3             closestPlayer\cf5 \strokec5 .\cf4 \strokec4 Position\cb1 \
\cb3         \cf5 \strokec5 )\cf4 \cb1 \strokec4 \
\cb3     \cf2 \strokec2 end\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 end\cf5 \strokec5 )\cf4 \cb1 \strokec4 \
}