
--[[
	Lua 语言中比较有意思的是在代码中可以用";"，
	也可以不用分号
	由于Lua是以中轻量级的脚本语言，所以学起来和用起来
	都是比较容易的，只要掌握他的基本用法，就可以融汇贯通的使用了

	需要注意的是 在Lua中的不等于不在是“!=”,而是“~=”
--]]

--引用其他lua文件,不需要加上（.lua）后缀
--require "xx"

require "lua"--引入其他文件
print(lua_admin);

--全局变量和局部变量
count = 199 --成员变量
local count = 199 --局部变量
--方法定义
function hello(...)
	print("HelloLua");
	print(...);
	-- print(string.FormattedTime("yyyy-MM-dd HH:mm:ss"));
end


-- 每一行代码不需要使用分隔符，当然也可以加上
-- 访问没有初始化的变量，lua默认返回nil


--调用函数
hello("this is a test demo for lua");

print("\n".."---------------基本数据类型-----------------");

--数据变量类型
isOk = false;
print(isOk);

-- 基本变量类型
a =nil --Lua 中值为nil 相当于删除
b =10
c =10.4
d =false
--定义字符串，单引号，双引号都可以的
e ="i am"
d ='leesong'
 
--两个字符串的连接可以如下形式
stringA ="lee"
stringB ="song"
print(stringA..stringB)
 
--另外Lua也支持转移字符，如下
print(stringA.."\n"..stringB);
 
--修改字符串的部分gsub，可以如下形式:(将stringA字符串中的Hi修改为WT)
stringA=string.gsub(stringA,"ee","WT");
print(stringA);
 
--将字符换成数字tonumber(不转也会自动转)
--将数字换成字符tostring(不转也会自动转)
stringC = "100"
stringC = tonumber(stringC);
stringC = stringC +20
stringC = tostring(stringC)
print(stringC)
 
--取一个字符串的长度使用 #
print(#stringC)
print("\n".."---------------创建表-----------------");

--[[
	创建表
--]]

tableA = {};
m = "x";
tableA[m] = 100;
m2 = 'y';
tableA[m2] = 200;
print(tableA["x"].."\n"..tableA.y);
--另外表还可以如下形式（从1开始）
tableB ={"4","5","6","7","8"}
print(tableB[1])
 
--算术操作符
c1 = 10+2
c2 = 10-2
c3 = 10*2
c4 = 10/2
c5 = 10^2
c6 = 10%2
c7 = -10+2
print(c1.."_"..c2.."_"..c3.."_"..c4.."_"..c5.."_"..c6.."_"..c7)


 print("\n".."----------------流程控制操作----------------");


--控制操作
--if then elseif then else end
abc =10
if  abc ==10 then
    print("v1")
elseif abc == 9 then
    print("v2")
else
    print("v3")
end
 
--for
--从4（第一个参数）涨到10（第二个参数），每次增长以2（第三个参数）为单位
for i=4,10,2 do
    print("for1:"..i+1)
end
--也可以不制定最后一个参数，默认1的增长速度
for i=4,10 do
    print("for2:"..i+1)
end
 
tableFor = {"himi1","himi2","himi3","himi4","himi5"}
for k,v in pairs(tableFor) do
    print("for3:key:"..k.."value:"..v)
end
 
--while
w1 = 20
while true do
    w1=w1+1
    if w1 ==25 then
        break
    end
end
print("whlile:"..w1)
 
--repeat
    aa =20
    repeat aa = aa+2
        print("repeat:"..aa)
    until aa>28
 
--关系操作符
--需要注意的是不等于符号 ~=  而不是!=
ax =10
bx =20
 
if ax >bx then
    print("GX1")
elseif ax<bx then
    print("GX2")
elseif ax>=bx then
    print("GX3")
elseif ax<=bx then
    print("GX4")
elseif ax==bx then
    print("GX5")
elseif ax~=bx then
    print("GX6")
else
    print("GX7")
end



print("\n".."--------------函数(方法)的定义------------------");

-- 定义一个函数
function funTestBackOne(aCount)
	local aCount = aCount + 1
	return aCount
end
--声明一个变量
 a=20
 print(funTestBackOne(a))

 --[[
 有多个返回参数的函数
 --]]
 function fun_BackMore()

     return 2,3
 	
 end

 a,b = fun_BackMore()
 print(a.." and " ..b)




 -- 有一个边长参数函数
function fun_unKnow(...)
	print(...)
end

fun_unKnow(a,b,"hah")

--[[
	闭合函数（一个函数写在另外一个函数内）
--]]

function cludeFuc(...)
	local d = 12;
	d = d +...

	function funTest(...)
		print(d)
	end

	funTest()
end

--[[
	掌握了以上的基本lua语言，在日常中做够用了
--]]












