using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using System.Web;

public partial class Member_setting : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);

        DataTable dt = skin.GetDT("select * from student_info where sole='" + GetSole() + "'");
        if (dt.Rows.Count > 0)
        { 
            name.InnerHtml = dt.Rows[0]["name"].ToString();
            code.InnerHtml = dt.Rows[0]["code"].ToString();
            sex.InnerHtml = dt.Rows[0]["sex"].ToString();
            organSole.InnerHtml = skin.ExecuteScalar("select name from admin_organ where sole='" + dt.Rows[0]["organSole"] + "'").ToString();
            dept.InnerHtml = dt.Rows[0]["dept"].ToString();
            uid.InnerHtml = dt.Rows[0]["uid"].ToString();
            pass.InnerHtml = dt.Rows[0]["pass"].ToString();
        }
    }
    protected void ImageButton1_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        skin.ExecuteSql("update student_info set savePath1='" + HiddenField1.Value + "' where sole='" + GetSole() + "'");

        HttpCookie cookie = new HttpCookie(SelfPerfix + "path");
        cookie.Value = HiddenField1.Value;
    }
}