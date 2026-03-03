<%@ WebHandler Language="C#" Class="ajax_full" %>

using System;
using System.Web;
using System.Text;
using System.Collections;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

/// <summary>处理分页请求信息</summary>
public class ajax_full : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        StringBuilder write = new StringBuilder();
        //分页对象
        harry.Model.Data.PagerInfo pager = harry.Tools.Web.RequestEx.GetPager();
        try
        {
            //Ajax操作类型
            if (pager.OperType != "")
            {
                ArrayList sql = new ArrayList();
                //表名
                int index = pager.TName.IndexOf(" as ");
                string table = index > -1 ? pager.TName.Substring(0, index) : pager.TName;
                switch (pager.OperType)
                {
                    //删除
                    case "ajax_del":
                        {
                            sql.Add("delete from " + table + " where id in(" + pager.Ids + ");");
                            //Log.Del(ids, tableName);
                            break;
                        }
                    //审核
                    case "ajax_audit":
                        {
                            sql.Add("update " + table + " set isAudit='" + pager.Value1 + "' where id in(" + pager.Ids + ");");
                            //Log.Audit(ids, tableName);
                            break;
                        }
                    //使用状态
                    case "ajax_used":
                        {
                            sql.Add("update " + table + " set isUsed='" + pager.Value1 + "' where id in(" + pager.Ids + ");");
                            //Log.Update(ids, tableName);
                            break;
                        }
                }
                //执行sql
                if (sql.Count > 0) { bool result = skin.Transaction(sql); }
            }

            //处理分页信息
            if (pager.Auto)
            {
                pager.TName += (pager.TName.IndexOf("as t1") > -1 ? "" : " as t1 ") + (pager.TName.IndexOf("t1.createSole=m1.id") > -1 || pager.TName.IndexOf("t1.createSole=m1.sole") > -1 ? "" : " left join [admin_per_manager] as m1 on t1.createSole=m1.id ");
                pager.Fields = pager.Fields + ",t1.sole";
            }
            //拼写json
            System.Data.DataTable dt = skin.GetPage(pager);
            write.Append("[{\"columns\":\"" + pager.Columns + "\",\"record\":\"" + pager.Record + "\",\"count\":\"" + pager.Count + "\"}]$$");
            write.Append(dt.DataToJson());
        }
        catch { throw; }

        //返回结果
        System.Web.HttpContext.Current.Response.ContentType = "text/plain";
        System.Web.HttpContext.Current.Response.Write(write.ToString());
        System.Web.HttpContext.Current.Response.End();
    }

    public bool IsReusable { get { return false; } }
}