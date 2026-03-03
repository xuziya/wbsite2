using System;
using harry.DAL.Sql.Sql2008;
using harry.Tools;
using Models.Admin.System;

public partial class Admin_sys_manager_manager_ad : AdminBasePage
{
    private string oper = string.Empty;
    private Skin<ManagerInfo> dal = new Skin<ManagerInfo>();
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //树形结构
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[admin_organ]", "0", " where isUsed=1 ");
            //Tools.TreeNode.AddNode(TreeView2.Nodes, "[publish_business]", "0", " where isUsed=1 ");

            //默认信息
            harry.Tools.Controls.AddToSelect(type, skin.GetDT("select name,name from admin_per_managerType where isUsed=1 order by id"), true);
            allowDate.Text = DateTime.Now.AddYears(1).ToString("yyyy-MM-dd");
            Button22.Visible = Button21.Visible = oper == "up";

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "0";
            if (oper == "up" && (id != "0" || sole != "0"))
            {
                ManagerInfo model = id != "" ? dal.Model(int.Parse(id)) : dal.Model(sole);
                if (model != null && model.Id != 0)
                {
                    ViewState["model"] = model;
                    organSole.Value = model.OrganSole;
                    if (organSole.Value != "") { organName.Text = skin.ExecuteScalar("select name from [admin_organ] where sole='" + organSole.Value + "'").ToString(); }
                    //relatedSole.Text = model.RelatedSole;
                    type.SelectedValue = model.Type;
                    name.Text = model.Name;
                    uid.Text = model.Uid;
                    //pass.Text = model.Pass;
                    //allowIp.Text = model.AllowIp;
                    //allowMac.Text = model.AllowMac;
                    allowDate.Text = model.AllowDate;
                    //popedom1.Value = model.Popedom;
                    //if (popedom1.Value != "") { popedom.Text = skin.ExecuteScalar("select name from [publish_business] where sole='" + popedom1.Value + "'").ToString(); }
                    isUsed.Checked = model.IsUsed == 1;
                    //isLogin.Checked = model.IsLogin == 1;
                    note.Text = model.Note;
                }
                else
                {
                    Button1.Visible = Button21.Visible = false;
                }
            }
        }
    }

    /// <summary>添加信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (organSole.Value == "") { this.Alert("请选择所属机构"); organName.Focus(); return; }
        if (name.Text == "") { this.Alert("请输入管理员姓名"); name.Focus(); return; }
        if (uid.Text == "") { this.Alert("请输入管理员账号"); uid.Focus(); return; }
        //if (pass.Text == "") { this.Alert("请输入管理员密码"); pass.Focus(); return; }

        //账号唯一性判断
        ManagerInfo old = ViewState["model"] as ManagerInfo;
        if (skin.ExecuteScalar("select id from [admin_per_manager] where name='" + name.Text + "'" + (oper == "up" ? " and id!=" + old.Id : "")).ToString() != "") { this.Alert("管理员姓名 [ " + name.Text + " ] 已被使用"); return; }
        if (skin.ExecuteScalar("select id from [admin_per_manager] where uid='" + uid.Text + "'" + (oper == "up" ? " and id!=" + old.Id : "")).ToString() != "") { this.Alert("管理员账号 [ " + uid.Text + " ] 已被使用"); return; }

        ManagerInfo model = new ManagerInfo();
        model.Id = oper == "add" ? 0 : old.Id;
        model.Sole = "";
        model.OrganSole = organSole.Value;
        //model.RelatedSole = relatedSole.Text;
        model.Type = type.SelectedValue;
        model.Name = name.Text;
        model.Uid = uid.Text;
        model.Pass = oper == "add" ? "123456" : old.Pass;

        //model.IconURL = "";
        //model.ProvincesSole = "";
        //model.CitySole = "";
        //model.CityName = "";
        //model.AreaSole = "";

        model.RegIp = harry.Tools.Web.RequestEx.Ip;
        //model.RegAddress = "";
        //model.AllowIp = allowIp.Text;
        //model.AllowMac = allowMac.Text;
        model.AllowDate = allowDate.Text;

        //model.Popedom = popedom1.Value;
        //model.Groups = "";
        //model.IsLogin = isUsed.Checked ? 1 : 0;
        model.IsAudit = 1;
        model.IsUsed = isUsed.Checked ? 1 : 0;//oper == "add" ? 0 : old.IsUsed;
        if (oper == "add")
        {
            model.LoginCount = 0;
            //model.LoginLastDate = "";
            model.CreateSole = GetSole();
            model.CreateDate = BasePage.GetDateTime();
        }
        model.Note = note.Text;
        int result = oper == "add" ? dal.Insert(model) : dal.Update(model);
        this.AlertSubmit(result > 0);
    }

    /// <summary>删除</summary>
    protected void Button21_Click(object sender, EventArgs e)
    {
        string[] alert = { "操作失败", "操作成功" };
        this.AlertSubmit(skin.ExecuteSql("delete from [admin_per_manager] where id=" + (Request["id"])) > 0, alert, true, "location.href", "");
    }

    /// <summary>重置</summary>
    protected void Button22_Click(object sender, EventArgs e)
    {
        string[] alert = { "操作失败", "操作成功" };
        this.AlertSubmit(skin.ExecuteSql("update [admin_per_manager] set pass='123456' where id=" + (Request["id"])) > 0, alert, true, "location.href", "");
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[admin_organ]", e.Node.Value, " where isUsed=1 ");
    }

    /// <summary>树形结构</summary>
    protected void TreeView2_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[publish_business]", e.Node.Value, " where isUsed=1 ");
    }
}