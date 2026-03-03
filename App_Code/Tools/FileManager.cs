using System;
using System.Collections.Generic;
using System.IO;
using System.Web;

namespace Tools
{

    public class FileItem
    {
        private string _name;               //名称
        private string _fullname;           //完整目录
        private DateTime _creationdate;     //创建时间
        private DateTime _lastaccessdate;   //最后访问时间
        private DateTime _lastwritedate;    //最后修改时间
        private bool _isfolder;             //是否是文件夹
        private double _size;               //大小
        private string _filecount;          //文件数
        private string _foldercount;        //文件夹数
        private string _version;            //版本
        private string _sizeM;

        public string SizeM
        {
            get { return _sizeM; }
            set { _sizeM = value; }
        }

        /// <summary>名称</summary>
        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        /// <summary>完整目录</summary>
        public string FullName
        {
            get { return _fullname; }
            set { _fullname = value; }
        }

        /// <summary>创建时间</summary>
        public DateTime CreationDate
        {
            get { return _creationdate; }
            set { _creationdate = value; }
        }

        /// <summary>是否是文件夹</summary>
        public bool IsFolder
        {
            get { return _isfolder; }
            set { _isfolder = value; }
        }

        /// <summary>大小</summary>
        public double Size
        {
            get { return _size; }
            set { _size = value; }
        }

        /// <summary>最后访问时间</summary>
        public DateTime LastAccessDate
        {
            get { return _lastaccessdate; }
            set { _lastaccessdate = value; }
        }

        /// <summary>最后修改时间</summary>
        public DateTime LastWriteDate
        {
            get { return _lastwritedate; }
            set { _lastwritedate = value; }
        }

        /// <summary>文件数</summary>
        public string FileCount
        {
            get { return _filecount; }
            set { _filecount = value; }
        }

        /// <summary>文件夹数</summary>
        public string FolderCount
        {
            get { return _foldercount; }
            set { _foldercount = value; }
        }

        /// <summary>
        /// 版本
        /// </summary>
        /// <returns></returns>
        public string Version()
        {
            if (_version == null)
                _version = GetType().Assembly.GetName().Version.ToString();
            return _version;
        }
    }

    public class FileManager
    {
        private string _rootFolder;

        public FileManager()
        {
            _rootFolder = HttpContext.Current.Request.PhysicalApplicationPath;
            _rootFolder = _rootFolder.Substring(0, _rootFolder.LastIndexOf(@"\"));
        }

        /// <summary>读根目录</summary>
        public string GetRootPath() { return _rootFolder; }

        /// <summary>写根目录</summary>
        public void SetRootPath(string path) { _rootFolder = path; }

        /// <summary>读取列表</summary>
        public List<FileItem> GetItems() { return GetItems(_rootFolder); }

        /// <summary>读取列表</summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public List<FileItem> GetItems(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string[] folders = Directory.GetDirectories(path);
            string[] files = Directory.GetFiles(path);
            List<FileItem> list = new List<FileItem>();

            long[] temp = new long[2];
            foreach (string s in folders)
            {
                FileItem item = new FileItem();
                DirectoryInfo di = new DirectoryInfo(s);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = true;
                double size = harry.Tools.IO.DirectoryEx.GetSize(di, true) / 1024;
                item.Size = size;
                item.SizeM = size >= 1024 ? Math.Round(size / 1024, 2) + " MB" : Math.Round(size, 2) + " KB";
                //item.FileCount = harry.Tools.IO.Directory.GetFileCount(di, true);
                temp = harry.Tools.IO.DirectoryEx.GetCount(di, true);
                item.FileCount = temp[0].ToString();
                item.FolderCount = temp[1].ToString();

                list.Add(item);
            }
            foreach (string s in files)
            {
                FileItem item = new FileItem();
                FileInfo fi = new FileInfo(s);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.IsFolder = true;
                item.Size = fi.Length / 1024;
                item.SizeM = item.Size >= 1024 ? Math.Round(item.Size / 1024, 2) + " MB" : Math.Round(item.Size, 2) + " KB";
                list.Add(item);
            }

            //string a = (path.ToLower() + "\\").Replace("\\\\", "\\");
            if ((path.ToLower() + "\\").Replace("\\\\", "\\") != (_rootFolder.ToLower() + "\\").Replace("\\\\", "\\"))
            {
                FileItem topitem = new FileItem();
                DirectoryInfo topdi = new DirectoryInfo(path).Parent;
                topitem.Name = "[上一级]";
                topitem.FullName = topdi.FullName;
                list.Insert(0, topitem);

                FileItem rootitem = new FileItem();
                DirectoryInfo rootdi = new DirectoryInfo(_rootFolder);
                rootitem.Name = "[根目录]";
                rootitem.FullName = rootdi.FullName;
                list.Insert(0, rootitem);

            }
            return list;
        }

        /// <summary>
        /// 读取文件夹
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public void CreateFolder(string name, string parentName)
        {
            DirectoryInfo di = new DirectoryInfo(parentName);
            di.CreateSubdirectory(name);
        }

        /// <summary>
        /// 删除文件夹
        /// </summary>
        /// <param name="path"></param>
        public void DeleteFolder(string path) { Directory.Delete(path, true); }

        /// <summary>
        /// 移动文件夹
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public void MoveFolder(string oldPath, string newPath) { Directory.Move(oldPath, newPath); }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        public void CreateFile(string filename, string path)
        {
            FileStream fs = File.Create(path + "\\" + filename);
            fs.Close();
        }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        /// <param name="contents"></param>
        public void CreateFile(string filename, string path, byte[] contents)
        {
            FileStream fs = File.Create(path + "\\" + filename);
            fs.Write(contents, 0, contents.Length);
            fs.Close();
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="path"></param>
        public void DeleteFile(string path) { File.Delete(path); }

        /// <summary>
        /// 移动文件
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public void MoveFile(string oldPath, string newPath) { File.Move(oldPath, newPath); }

        /// <summary>
        /// 读取文件信息
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public FileItem GetItemInfo(string path)
        {
            FileItem item = new FileItem();
            if (Directory.Exists(path))
            {
                DirectoryInfo di = new DirectoryInfo(path);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = true;
                item.LastAccessDate = di.LastAccessTime;
                item.LastWriteDate = di.LastWriteTime;
                item.FileCount = di.GetFiles().Length.ToString();
                item.FolderCount = di.GetDirectories().Length.ToString();
            }
            else
            {
                FileInfo fi = new FileInfo(path);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.LastAccessDate = fi.LastAccessTime;
                item.LastWriteDate = fi.LastWriteTime;
                item.IsFolder = false;
                item.Size = fi.Length;
            }
            return item;
        }

        /// <summary>
        /// 复制文件夹
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public void CopyFolder(string source, string destination)
        {
            String[] files;
            if (destination[destination.Length - 1] != Path.DirectorySeparatorChar)
                destination += Path.DirectorySeparatorChar;
            if (!Directory.Exists(destination)) Directory.CreateDirectory(destination);
            files = Directory.GetFileSystemEntries(source);
            foreach (string element in files)
            {
                if (Directory.Exists(element))
                    CopyFolder(element, destination + Path.GetFileName(element));
                else
                    File.Copy(element, destination + Path.GetFileName(element), true);
            }
        }
    }
}