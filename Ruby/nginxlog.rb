puts "# 雅诗运维工具 Nginx 日志文件解析"
puts "- 正在读入Nginx日志文件 #{ARGV[0]} ..."
if !ARGV[0]
    puts "- 没有指定文件。"
end
file = File.open(ARGV[0],"r")
httpcodes = {} # 统计状态码出现次数
httpcodesdc = {} # 统计状态码出现次数-流量
allsize = 0 # 全部大小计数
allline = 0 # 行数统计，当然进展的行数
filesize = File.size(ARGV[0]) # 获得文件大小计算进度用
savesize = 0 # 已处理字节数计算进度用
oldpercentage = 0.00 # 上次显示的进度百分比，有变化再输出
hour = Array.new(24, 0) # 用于统计小时访问
hourdc = Array.new(24, 0) # 用于统计小时访问-流量
httpchmods = {} # 统计传输方式出现次数
httpchmodsdc = {} # 统计传输方式出现次数-流量
hits = 0 # 缓存命中统计
hitsdc = 0 # 缓存命中统计-流量
uatype1 = ["bot","spider","iPod","iPad","iPhone","Android","Macintosh","Windows","Mac OS","Linux"]
uatype2 = ["MicroMessenger","Baidu","Maxthon","360","QQ","Edg","MSIE","Chrome","Opera","Safari","Mozilla","jetmon","Feedly"]
uatypes1 = {}
uatypesdc1 = {}
uatypes2 = {}
uatypesdc2 = {}
datacount = 0;
while line = file.gets
    allline += 1
    nowinfos = Array.new
    tmpstr = "";
    tmping = false
    ipaddrend = false
    igrnextspace = false
    timeend = false
    # 将每行数据转换为数组
    line.each_char{|nowchar|
        if ipaddrend == false and nowchar == ','
            igrnextspace = true
        end
        if (nowchar == '[' and !timeend) or (nowchar == '"' and !tmping)
            tmping = true
            if nowchar == '"'
                ipaddrend = true
            end
        elsif (nowchar == ']' and !timeend) or (nowchar == '"' and tmping) or (nowchar == ' ' and !tmping and !igrnextspace)
            if nowchar == ']'
                timeend = true
            end
            tmping = false
            if nowchar == ' '
                igrnextspace = false
            end
            # if tmpstr != ""
                nowinfos << tmpstr
                tmpstr = "";
            # end
        else
            tmpstr += nowchar
        end
        if nowchar == ' '
            igrnextspace = false
        end
    }
    # 开始进行分析
    if (nowinfos.length != 16)
        puts "E: 数据长度不匹配, 不应是 #{nowinfos.length} , 行 #{allline}"
        puts line
        ii = 0
        nowinfos.each{|iiiii|
            puts "#{ii} #{iiiii}"
            ii += 1
        }
    end
    nowdata = nowinfos[11].to_i; # 当前流量
    # 分析返回HTTP代码的出现次数
    if httpcodes[nowinfos[9]]
        httpcodes[nowinfos[9]] += 1
        httpcodesdc[nowinfos[9]] += nowdata
    else
        httpcodes[nowinfos[9]] = 1
        httpcodesdc[nowinfos[9]] = nowdata
    end
    # 分析每小时访问量
    nowhour = nowinfos[0].split(':')[1].to_i
    hour[nowhour] += 1
    hourdc[nowhour] += nowdata
    # 分析请求类型
    httpchmod = nowinfos[7].split(' ')[0]
    # 分析返回HTTP请求模式的出现次数
    if httpchmods[httpchmod]
        httpchmods[httpchmod] += 1
        httpchmodsdc[httpchmod] += nowdata
    else
        httpchmods[httpchmod] = 1
        httpchmodsdc[httpchmod] = nowdata
    end
    # 分析传输流量
    datacount += nowdata
    # 分析缓存命中率
    if nowinfos[12] == "HIT"
        hits += 1
        hitsdc += nowdata
    end
    # 分析设备
    nowua = nowinfos[13]
    isgettype = false
    uatype1.each{|nowtype|
        if nowua.index(nowtype)
            isgettype = true
            if uatypes1[nowtype]
                uatypes1[nowtype] += 1
                uatypesdc1[nowtype] += nowdata
            else
                uatypes1[nowtype] = 1
                uatypesdc1[nowtype] = nowdata
            end
            break
        end
    }
    if !isgettype
        if uatypes1["其他设备"]
            uatypes1["其他设备"] += 1
            uatypesdc1["其他设备"] += nowdata
        else
            uatypes1["其他设备"] = 1
            uatypesdc1["其他设备"] = nowdata
        end
    end
    # 分析浏览器
    isgettype = false
    uatype2.each{|nowtype|
        if nowua.index(nowtype)
            isgettype = true
            if uatypes2[nowtype]
                uatypes2[nowtype] += 1
                uatypesdc2[nowtype] += nowdata
            else
                uatypes2[nowtype] = 1
                uatypesdc2[nowtype] = nowdata
            end
            break
        end
    }
    if !isgettype
        if uatypes2["其他浏览器"]
            uatypes2["其他浏览器"] += 1
            uatypesdc2["其他浏览器"] += nowdata
        else
            uatypes2["其他浏览器"] = 1
            uatypesdc2["其他浏览器"] = nowdata
        end
    end
    # 统计
    savesize += line.length
    percentage = savesize.to_f/filesize.to_f*100
    percentage = format("%.1f",percentage).to_f
    if oldpercentage < percentage
        oldpercentage = percentage
        puts "- 文件大小:#{filesize}, 已解析:#{savesize}, 已完成:#{percentage}%"
    end
end

def datainfostr(datacount)
    if datacount == 0
        return "没有产生流量"
    end
    mb = datacount.to_f/1024/1024
    mb = format("%.2f",mb).to_f
    return "流量 #{datacount} 字节 ( #{mb} MB )"
end

def addzero(num)
    if num < 10
        return "0#{num}"
    end
    return "#{num}"
end

def getSort(arr2,arr)
    len = arr.length
    for i in 0...len-1
        for j in 0...len-i-1
            if arr[j].to_i > arr[j+1].to_i
                temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
                temp = arr2[j]
                arr2[j] = arr2[j+1]
                arr2[j+1] = temp
            end
        end
    end
end

puts "\n# 雅诗运维工具 Nginx 日志文件解析结果"
puts "- 报告生成时间: #{Time.new.strftime("%Y-%m-%d %H:%M:%S")}"
puts "## HTTP请求结果状态码返回次数："
httpcodes.each{|nkey,nval|
    percentage = nval.to_f/allline.to_f*100
    percentage = format("%.2f",percentage).to_f
    puts "- 状态码 #{nkey} 出现了 #{nval} 次, 占比 #{percentage} %, #{datainfostr(httpcodesdc[nkey])}"
}
puts "## HTTP请求时段："
for i in 0..23
    nval = hour[i]
    percentage = nval.to_f/allline.to_f*100
    percentage = format("%.2f",percentage).to_f
    puts "- #{addzero(i)} 点到 #{addzero(i+1)} 点钟总计收到访问 #{nval} 次, 占比 #{percentage} %, #{datainfostr(hourdc[i])}"
end
puts "## HTTP请求模式的出现次数："
httpchmods.each{|nkey,nval|
    percentage = nval.to_f/allline.to_f*100
    percentage = format("%.2f",percentage).to_f
    puts "- 使用 #{nkey} 方式传输了 #{nval} 次数据, 占比 #{percentage} %, #{datainfostr(httpchmodsdc[nkey])}"
}
puts "## 缓存命中次数："
puts "- 总计连接 #{allline} 次, #{datainfostr(datacount)}"
puts "- 静态缓存命中 #{hits} 次, #{datainfostr(hitsdc)}"
puts "- 生成内容 #{allline-hits} 次, #{datainfostr(datacount-hitsdc)}"
hitpercentage = hits.to_f/allline.to_f*100
hitpercentage = format("%.2f",hitpercentage).to_f
puts "- 命中率 #{hitpercentage} %"
puts "## 访问者设备特征："
uatypesk = uatypes1.keys
uatypesv = uatypes1.values
uatypesl = uatypesk.length-1
getSort(uatypesk,uatypesv)
for i in 0...uatypesl
    nkey = uatypesk[uatypesl-i]
    nval = uatypesv[uatypesl-i]
    percentage = nval.to_f/allline.to_f*100
    percentage = format("%.2f",percentage).to_f
    puts "- 使用设备 #{nkey} 进行了 #{nval} 次访问, 占比 #{percentage} %, #{datainfostr(uatypesdc1[nkey])}"
end
puts "## 访问者浏览器特征："
uatypesk = uatypes2.keys
uatypesv = uatypes2.values
uatypesl = uatypesk.length-1
getSort(uatypesk,uatypesv)
for i in 0...uatypesl
    nkey = uatypesk[uatypesl-i]
    nval = uatypesv[uatypesl-i]
    percentage = nval.to_f/allline.to_f*100
    percentage = format("%.2f",percentage).to_f
    puts "- 使用浏览器 #{nkey} 进行了 #{nval} 次访问, 占比 #{percentage} %, #{datainfostr(uatypesdc2[nkey])}"
end