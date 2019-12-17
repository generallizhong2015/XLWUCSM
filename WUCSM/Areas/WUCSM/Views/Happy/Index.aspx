<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>温馨提示--长益西联软件</title>
    <link href="../../../../CSS/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="wznr">
    <h1>温馨提示</h1>
    <h2>尊敬的客户朋友：</h2>
    <p>在你们的支持与配合下，长益西联软件公司客户服务部陪伴你们一起努力工作，共同走过了又一个年头。在此，客户服务部所有工作人员对广大客户朋友给予我们工作的支持与配合表示忠心的感谢！</p>
    <p>每年春节前夕，是零售企业生意最为繁忙的一个时期，大家在确保生意兴隆的同时，请务必检查和保证管理系统数据的安全性，特别要认真进行数据备份（数据灾备）工作，以免因设备损毁等原因造成数据丢失，给企业经营带来不必要的麻烦与损失。</p>
    <p>在此我们提示广大客户朋友们针对各个环节做好节前必要的检查工作，存在隐患的地方及时做好处理和改善。</p>
    <p class="wzys">一、	针对各总部、配送、门店、会员卡（券）系统等，软件系统的数据库做好备份。最好每日定时异机备份。具体处理办法参考 <a href="#content" style=" text-decoration:none">《数据安全管理要求》</a>，请各企业务必落实专人负责。</p>
    <p class="wzys">二、	做好收银机及相关设备的检查工作，如有问题及时维修。相关耗材是否准备充裕（如:小票打印纸、碳带、电子秤价签纸等）。</p>
    <p class="wzys">三、	收银系统的网络环境检测，如有网线阻断等情况，及时做好重新布线等处理。数据通讯是否正常，如果有故障及时处理。</p>
    <p class="wzys"> 四、	节假期间的变价、特价、促销活动的业务数据是否正常。以及收银系统是否能正常执行。</p>
    <p>以上工作事项，如有不明确的问题，可与我公司客户服务部工作人员联系，我们会尽全力配合广大客户做好各项检查及备份工作。</p>
    <p>最后，我们给广大客户朋友拜年啦！祝愿所有客户在2016年生意兴隆、工作顺心、万事如意！！</p>
    <p>此致</p>
    <p style="text-indent: 4em;">敬礼！</p>
    <p style="text-align: right">长益西联软件  客户服务部</p>
    <p style="text-align: right">2016年元月7日</p>
        <div id="content">    
            <h1 style="margin-top: 30px;">数据安全管理要求</h1>
            <p style="color: #ffffff; font-weight: bold; font-size: 16px;"> 1、	每日数据备份</p>
            <p class="wzys">（1）	每日营业完毕后（或每日上午10点），电脑部系统管理员或专门人员必须进行数据备份；</p>
            <p class="wzys">（2）	备份数据内容：A）VIP及储值卡系统数据，B）商业管理系统经营数据；</p>
            <p class="wzys">（3）	备份要求：异机备份、异地保存；或用移动硬盘进行数据备份；</p>
            <p class="wzys">（4）	数据备份完毕后，备份人必须检查并确认本次数据备份成功；</p>
            <p class="wzys">（5）	若本次备份数据未成功备出，必须重新进行数据备份直至成功备份，必要时可联系软件公司进行技术支持；</p>
            <p class="wzys">（6）	数据成功备份完毕后，备份人必须在纸质数据备份日志上签字确认。</p>
            <p style="color: #ffffff; font-weight: bold; font-size: 16px;"> 2、	每周数据备份状况检查</p>
            <p class="wzys">（1）	每周五下午，总部安排专人对总部及各门店的备份数据进行远程核查；</p>
            <p class="wzys">（2）	每周五下午，总部及各门店财务对总部及门店的储值卡系统数据进行数据备份，并签字确认检查结果；</p>
            <p class="wzys">（3）	总部核查完毕后，核查人必须在纸质数据备份日志上签字确认；</p>
            <p class="wzys">（4）	总部及门店未按要求进行数据备份，要对责任人进行处罚。</p>
            <p style="color: #ffffff; font-weight: bold; font-size: 16px;">3、	其它要求</p>
            <p class="wzys">（1）	若数据备份设备发生故障，必须立即启用新设备重新进行数据备份。</p>
            <p class="wzys">（2）	若服务器发生故障，必须立即将已备份的数据进行第二副本备份。</p>
            <p class="wzys">（3）	要确保任何时候都有两套数据存在（或服务器+备份数据，或两套备份数据）。</p>
            <p class="wzys">（4）	财务必须确保：A）长期保存储值卡发放（或充值）的纸质凭证；B）储值卡消费存根收据保留两周以上。</p>
            <p class="wzys">（5）	备份数据包必须保留最近三次的备份数据。</p>
            <p class="wzys">（6）	备份数据必须安全保存，严禁泄密，并随时删除可能造成外泄的垃圾备份数据，避免被无关人员窃取数据。</p>
        </div>

</div>
</body>
</html>
<%--<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        closeit();
    });
    function closeit() {
        setTimeout("self.close()", 40000)
    }
       
</script>--%>

