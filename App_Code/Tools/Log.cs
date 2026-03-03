using System.Collections;
using harry.DAL.Sql.Sql2008;

namespace Tools
{
    /// <summary>日志操作类</summary>
    public class Log
    {
        /// <summary>登陆日志：正常</summary>
        /// <param name="fromTable">登录信息的来源表名</param>
        /// <param name="type">类型</param>
        /// <param name="createSole">操作人编号</param>
        /// <returns></returns>
        public static bool Login1(string fromTable, string type, string createSole)
        {
            string date = BasePage.GetDateTime();
            ArrayList sql = new ArrayList();
            //添加登陆日志
            sql.Add("insert into [admin_log_login] values('','" + type + "',0,'" + harry.Tools.Web.RequestEx.Ip + "','','正常','" + createSole + "','" + date + "','');");
            //设置用户登陆次数、最后登录时间
            sql.Add("update " + fromTable + " set loginCount=loginCount+1,loginLastDate='" + date + "' where sole='" + createSole + "';");
            //设置登陆日志编号、排序
            sql.Add("update [admin_log_login] set sole=id,indexs=(select loginCount from " + fromTable + " where sole='" + createSole + "') where id=ident_current('[admin_log_login]');");
            return skin.Transaction(sql);
        }

        /// <summary>登陆日志：正常</summary>
        /// <param name="fromTable">登录信息的来源表名</param>
        /// <param name="type">类型</param>
        /// <param name="createSole">操作人编号</param>
        /// <returns></returns>
        public static bool Login2(string fromTable, string type, string createSole)
        {
            string date = BasePage.GetDateTime();
            ArrayList sql = new ArrayList();
            //添加登陆日志
            sql.Add("insert into [member_log_login] values('','" + type + "',0,'" + harry.Tools.Web.RequestEx.Ip + "','','正常','" + createSole + "','" + date + "','');");
            //设置用户登陆次数、最后登录时间
            sql.Add("update " + fromTable + " set loginCount=loginCount+1,loginLastDate='" + date + "' where sole='" + createSole + "';");
            //设置登陆日志编号、排序
            sql.Add("update [member_log_login] set sole=id,indexs=(select loginCount from " + fromTable + " where sole='" + createSole + "') where id=ident_current('[member_log_login]');");
            return skin.Transaction(sql);
        }

        /// <summary>登陆日志：异常</summary>
        /// <param name="fromTable">登录信息的来源表名</param>
        /// <param name="type">类型</param>
        /// <param name="createSole">操作人编号</param>
        /// <param name="uid">账号</param>
        /// <param name="pass">密码</param>
        /// <param name="result">验证结果</param>
        /// <returns></returns>
        public static bool LoginError(string fromTable, string type, string createSole, string uid, string pass, string result)
        {
            string date = BasePage.GetDateTime();
            string ip = harry.Tools.Web.RequestEx.Ip;
            ArrayList sql = new ArrayList();
            //添加登陆日志
            sql.Add("insert into " + fromTable + " values('','" + type + "',0,'" + ip + "','','异常','" + createSole + "','" + date + "','管理员账号：" + uid + "，管理员密码：" + uid + "，结果：" + result + "');");
            //设置登陆日志编号、排序
            sql.Add("update " + fromTable + " set sole=id where id=ident_current('" + fromTable + "');");//,indexs=(select index from [admin_log_login] where loginIp='" + ip + "' and type='失败')+1
            return skin.Transaction(sql);
        }
    }
}