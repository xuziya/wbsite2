using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using harry.Tools;
using Tools;

public partial class Admin_sys_other_fileManager : AdminBasePage
{
    private const string filepath = "/Tools/fileManager";
    private FileManager fileManager = new FileManager();
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            string bp = Request["bp"] ?? "";
            if (Request["opers"] != null && Request["opers"].ToString() == "none") { opers.Visible = false; }
            //ViewState["type"] = ViewState["type"] != null ? ViewState["type"].ToString() : (Request["t"] ?? "");
            //string t = ViewState["type"].ToString();
            //if (ViewState["type"] == "s")
            //{
            //    if (bp == "") { this.Alert("您的空间大小为0，有需要联系系统管理员或空间提供商", -1); }
            //}
            if (bp != "")
            {
                bp = (Server.MapPath("~/" + bp) + "\\").Replace("\\\\", "");
                ViewState.Add("basePath", bp);
                fileManager.SetRootPath(bp);
                BindGrid(bp);
            }
            else { this.AlertHistory("根目录错误", -1); }
        }
        else fileManager.SetRootPath(ViewState["basePath"].ToString());
    }

    private void BindGrid(string path)
    {
        List<FileItem> list = fileManager.GetItems(path);
        GridView1.DataSource = list;
        GridView1.DataBind();
        lblCurrentPath.Text = path;
    }

    /// <summary>标题栏内容</summary>
    public string GetTitle()
    {
        string title = Request["title"] ?? "", result = "";
        if (title != "")
        {
            string[] t = title.Split("-".ToCharArray());
            for (int i = 0; i < t.Length; i++)
            {
                if (t[0] == "管理员") { result += "<li class='active'><a href='/Admin/main.aspx'>首页</a></li>"; }
                else if (t[0] == "用户") { result += "<li class='active'><a href='/Member/main.aspx'>首页</a></li>"; }
                else { result += "<li><a " + (i == t.Length - 1 ? " class='active'" : "") + ">" + t[i] + "</a></li>"; }
            }
        }
        else { result = "<li class='active'><a href='/Admin/main.aspx'>首页</a></li><li><a>系统设置</a></li><li><a>其他功能</a></li><li class='active'><a>在线FTP系统</a></li>"; }
        return result;
    }
    /// <summary>操作栏显示状态</summary>
    public string GetEditorState()
    {
        return " style='display:" + ((Request["editor"] ?? "1") == "1" ? "" : "none") + "'";
    }
    /// <summary>路径栏显示状态</summary>
    public string GetSavePathState()
    {
        return "display:" + ((Request["path"] ?? "1") == "1" ? "" : "none");
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lb = (LinkButton)e.Row.Cells[1].FindControl("LinkButton1");
            if (lb.Text != "[根目录]" && lb.Text != "[上一级]")
            {
                if (Directory.Exists(lb.CommandArgument.ToString()))
                {
                    lb.Text = string.Format("<img src=\"" + filepath + "/images/file/folder.gif\" style=\"border:none; vertical-align:middle;\" /> {0}", lb.Text);
                }
                else
                {
                    string ext = lb.CommandArgument.ToString().Substring(lb.CommandArgument.LastIndexOf(".") + 1);
                    if (File.Exists(Server.MapPath(string.Format("" + filepath + "/images/file/{0}.gif", ext))))
                    {
                        lb.Text = string.Format("<img src=\"" + filepath + "/images/file/{0}.gif\" style=\"border:none; vertical-align:middle;\" /> {1}", ext, lb.Text);
                    }
                    else
                    {
                        lb.Text = string.Format("<img src=\"" + filepath + "/images/file/other.gif\" style=\"border:none; vertical-align:middle;\" /> {0}", lb.Text);
                    }
                }
            }
            else
            {
                Image iii = e.Row.Cells[0].FindControl("Image1") as Image;
                if (iii != null)
                {
                    if (lb.Text == "[根目录]")
                    {
                        iii.ImageUrl = "/Tools/fileManager/images/root.gif";
                    }
                    iii.Visible = true;
                }
                CheckBox ck = e.Row.Cells[0].FindControl("CheckBox1") as CheckBox;
                if (ck != null) ck.Visible = false;
                //e.Row.Cells[0].Controls.Clear();
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";
                e.Row.Cells[4].Text = "";
            }
            //间隔行换色 张金朋注释
            //if (e.Row.RowIndex % 2 == 0){e.Row.Attributes.Add("style", "background-color:white");}
        }
    }

    //鼠标底色
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //张金朋删除 鼠标经过换色
            //e.Row.Attributes.Add("onmouseover", "c=this.style.backgroundColor;this.style.backgroundColor='#D7E6F5';");
            //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=c;");
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string filePath = e.CommandArgument.ToString();
        if (Directory.Exists(filePath))
        {
            BindGrid(filePath);
        }
        else
        {
            filePath = filePath.Replace(fileManager.GetRootPath(), "~");
            filePath = filePath.Replace("\\", "/");
            string s = ViewState["basePath"].ToString() + filePath.Replace("~", "").Replace("~/", "\\");
            System.IO.FileInfo file = new System.IO.FileInfo(s);
            if (file.Exists)
            {
                harry.Tools.Web.ResponseEx.WriteFile(file);
            }
            else
            {
                this.Alert("文件不存在或已被删除");
            }
        }
    }

    #region 文件操作

    /// <summary>
    /// 删除
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    if (Directory.Exists(lb.CommandArgument))
                    {
                        fileManager.DeleteFolder(lb.CommandArgument);
                    }
                    else
                    {
                        fileManager.DeleteFile(lb.CommandArgument);
                    }
                }
            }
        }
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 新建文件夹
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCreateFolder_Click(object sender, EventArgs e)
    {
        string filederName = TextBox2.Text.Trim();
        fileManager.CreateFolder(filederName, lblCurrentPath.Text);
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 新建文件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCreateFile_Click(object sender, EventArgs e)
    {
        fileManager.CreateFile(TextBox4.Text, lblCurrentPath.Text);
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 上传
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string path = lblCurrentPath.Text + "\\";
            path += Path.GetFileName(FileUpload1.FileName);
            FileUpload1.PostedFile.SaveAs(path);
            BindGrid(lblCurrentPath.Text);
        }
    }

    /// <summary>
    /// 剪切
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCut_Click(object sender, EventArgs e)
    {
        List<string> items = new List<string>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    items.Add(lb.CommandArgument);
                }
            }
        }
        ViewState["clipboard"] = items;
        ViewState["action"] = "cut";
    }

    /// <summary>
    /// 粘贴
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnPaste_Click(object sender, EventArgs e)
    {
        if (ViewState["clipboard"] != null)
        {
            if (ViewState["action"].ToString() == "cut")
            {
                List<string> items = (List<string>)ViewState["clipboard"];
                foreach (string s in items)
                {
                    if (Directory.Exists(s))
                    {
                        string endPath = Path.GetFullPath(lblCurrentPath.Text + s.Substring(s.LastIndexOf("\\")));
                        if (!Path.GetFullPath(s).Equals(endPath))
                        {
                            if (Path.GetFullPath(s).Length > endPath.Length)
                                Directory.Move(s, endPath);
                            else if (Path.GetFullPath(s).Length < endPath.Length && !endPath.Substring(0, Path.GetFullPath(s).Length + 1).Equals(Path.GetFullPath(s) + @"\"))
                                Directory.Move(s, endPath);
                            else
                            {
                                this.Alert("无法移动，目标文件夹和源文件夹相同。");
                                return;
                            }
                        }
                        else
                        {
                            this.Alert("无法移动，目标文件夹和源文件夹相同。");
                            return;
                        }
                    }
                    else
                    {
                        File.Move(s, lblCurrentPath.Text + "\\" + Path.GetFileName(s));
                    }
                }
            }
            else
            {
                List<string> items = (List<string>)ViewState["clipboard"];
                foreach (string s in items)
                {
                    if (Directory.Exists(s))
                    {
                        DirectoryInfo di = new DirectoryInfo(s);
                        fileManager.CopyFolder(s, lblCurrentPath.Text + "\\" + di.Name);
                    }
                    else
                    {
                        File.Copy(s, lblCurrentPath.Text + "\\复件 " + Path.GetFileName(s), true);
                    }
                }
            }
        }
        ViewState["clipboard"] = null;
        ViewState["action"] = null;
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 复制
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCopy_Click(object sender, EventArgs e)
    {
        List<string> items = new List<string>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    items.Add(lb.CommandArgument);
                }
            }
        }
        ViewState["clipboard"] = items;
        ViewState["action"] = "copy";
    }

    /// <summary>
    /// 重命名
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnRename_Click(object sender, EventArgs e)
    {
        string src = "";
        string dest = "";
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    src = lb.CommandArgument;
                }
            }
        }
        if (src.Length > 0)
        {
            dest = src.Substring(0, src.LastIndexOf('\\'));
            dest = dest + "\\" + TextBox3.Text;
            if (Directory.Exists(src))
            {
                fileManager.MoveFolder(src, dest);
            }
            else
            {
                fileManager.MoveFile(src, dest);
            }
            BindGrid(lblCurrentPath.Text);
        }
    }

    #endregion
}