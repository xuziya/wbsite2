-- 创建大模型对话记录表
CREATE TABLE llm_log (
    id INT IDENTITY(1,1) PRIMARY KEY,
    studentName NVARCHAR(50) NOT NULL,
    dialogContent NVARCHAR(MAX) NOT NULL,
    score FLOAT DEFAULT 0,
    evaluation NVARCHAR(MAX),
    dialogTime DATETIME NOT NULL
);

-- 创建索引
CREATE INDEX IX_llm_log_dialogTime ON llm_log(dialogTime);
CREATE INDEX IX_llm_log_studentName ON llm_log(studentName);