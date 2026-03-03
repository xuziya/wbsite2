<%@ WebHandler Language="C#" Class="ajax_tree" %>

using System;
using System.Web;
using System.Text;
using System.Collections;
using harry.DAL.Sql.Sql2008;

/// <summary>处理树形结构请求信息</summary>
public class ajax_tree : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        StringBuilder write = new StringBuilder();
        HttpRequest request = HttpContext.Current.Request;
        HttpResponse response = HttpContext.Current.Response;
        try
        {
            //请求参数
            string at = request["at"] ?? "";
            string tb = request["tb"] ?? "";
            switch (at)
            {
                //添加
                case "addNode":
                    {
                        write.Append(Tools.TreeNode.InsertNode(tb, request));
                        break;
                    }
                //删除
                //case "remove_all":
                //    {
                //        string ps = request["ps"] ?? "";
                //        string sole = request["sole"] ?? "";
                //        ArrayList sql = new ArrayList();
                //        sql.Add("delete from [publish_planPage] where sole='" + sole + "';");
                //        sql.Add("delete from [publish_planDetail] where pageSole='" + sole + "';");
                //        sql.Add("delete from [publish_planFiles] where pageSole='" + sole + "';");
                //        sql.Add("delete from [publish_planMenus] where int1=" + sole);
                //        write.Append(skin.Transaction(sql).ToString().ToLower());
                //        break;
                //    }
            }
        }
        catch { throw; }
        //返回结果
        response.ContentType = "text/plain";
        response.Write(write.ToString());
        response.End();
    }

    public bool IsReusable { get { return false; } }
}