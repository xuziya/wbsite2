using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_sys_manager_organ_up : System.Web.UI.Page
{
    private const string tableName = "[admin_organ]";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //显示信息
            string sole1 = Request["sole"] ?? "";
            if (sole1 != "")
            {

                DataTable dt = skin.GetDT("select pr.*,m1.name as m1name from " + tableName + " as pr left join admin_per_manager as m1 on pr.createSole=m1.sole where pr.sole='" + sole1 + "'");
                if (dt.Rows.Count > 0)
                {
                    type.SelectedValue = dt.Rows[0]["type"].ToString();
                    areaSole.Value = dt.Rows[0]["string2"].ToString();
                    if (areaSole.Value != "") { areaName.Text = skin.ExecuteScalar("select path+'-'+name from [data_area] where sole='" + areaSole.Value + "'").ToString(); }
                    name.Text = dt.Rows[0]["name"].ToString();
                    string1.Text = dt.Rows[0]["string1"].ToString();
                    popedom.Text = dt.Rows[0]["popedom"].ToString();
                    indexs.Text = dt.Rows[0]["indexs"].ToString();
                    note.Text = dt.Rows[0]["note"].ToString();
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    id.InnerText = dt.Rows[0]["id"].ToString();
                    sole.InnerText = dt.Rows[0]["sole"].ToString();
                    code.InnerHtml = dt.Rows[0]["code"].ToString() != "" ? dt.Rows[0]["code"].ToString() : "&nbsp;";
                    path.Text = dt.Rows[0]["path"].ToString() != "" ? dt.Rows[0]["path"].ToString() : "&nbsp;";
                    lev.InnerText = dt.Rows[0]["lev"].ToString();
                    createSole.InnerText = dt.Rows[0]["m1name"].ToString();
                    createDate.InnerHtml = dt.Rows[0]["createDate"].ToString() != "" ? dt.Rows[0]["createDate"].ToString() : "&nbsp;";
                }
            }
            Button1.Visible = sole1 != "";
            Button2.Visible = skin.ExecuteScalar("select count(id) from " + tableName + " where parentSole='" + sole1 + "'").ToString() == "0";

            //机构信息
            string asole = harry.DAL.Sql.Sql2008.skin.ExecuteScalar("select v1 from [admin_setting] where type='系统设置' and name='应用设置'").ToString();
            if (asole != "") { Tools.TreeNode.AddArea(TreeView1.Nodes, "", " where isUsed=1 and sole='" + asole + "'", "", 1, false); }
            else { harry.Tools.Js.Alert(this, "无效的区域信息"); }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if ((Request["sole"] ?? "") == "") { this.Alert("请选择节点后操作"); return; }
        if (name.Text == "") { this.Alert("请输入机构名称"); name.Focus(); return; }
        //if (areaSole.Value == "") { this.Alert("请选择行政区域"); return; }
        bool result = skin.ExecuteSql("update " + tableName + " set [type]='" + type.SelectedValue + "',[name]='" + name.Text + "',[popedom]='" + popedom.Text + "',[string1]='" + string1.Text + "',[string2]='" + areaSole.Value + "',[isUsed]=" + (isUsed.Checked ? "1" : "0") + ",[indexs]='" + indexs.Text + "',[path]='" + path.Text + "',[note]='" + note.Text + "' where sole='" + sole.InnerHtml + "'") > 0;
        this.Script(result ? "top.messageBox('操作成功');window.parent.location.reload();" : "top.messageBox('操作失败');");
    }

    /// <summary>删除信息</summary>
    protected void Button2_Click(object sender, EventArgs e)
    {
        string code = skin.ExecuteScalar("select code from " + tableName + " where sole='" + (Request["sole"] ?? "") + "'").ToString();
        if (code != "")
        {
            int result = skin.ExecuteSql("delete from " + tableName + " where sole='" + (Request["sole"] ?? "") + "' or code like '" + code + "-%'");
            this.Script(result > 0 ? "top.messageBox('操作成功');window.parent.location.reload();" : "top.messageBox('操作失败');");
        }
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddArea(e.Node.ChildNodes, e.Node.Value, " where isUsed=1 ", "", 1, false);
    }
}