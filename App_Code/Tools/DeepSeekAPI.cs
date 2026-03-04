using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;

namespace Tools
{
    public class DeepSeekAPI
    {
        private string baseUrl;
        private string apiKey;
        private JavaScriptSerializer serializer;

        public DeepSeekAPI(string baseUrl, string apiKey)
        {
            this.baseUrl = baseUrl;
            this.apiKey = apiKey;
            this.serializer = new JavaScriptSerializer();
        }

        public class Message
        {
            public string role { get; set; }
            public string content { get; set; }
        }

        public class Request
        {
            public string model { get; set; }
            public List<Message> messages { get; set; }
            public float temperature { get; set; }
            public int max_tokens { get; set; }
        }

        public class Choice
        {
            public Message message { get; set; }
            public string finish_reason { get; set; }
            public int index { get; set; }
        }

        public class Response
        {
            public string id { get; set; }
            public string type { get; set; }
            public int created { get; set; }
            public string model { get; set; }
            public List<Choice> choices { get; set; }
        }

        public string GenerateResponse(string model, List<Message> messages, float temperature = 0.7f, int maxTokens = 1000)
        {
            try
            {
                var requestData = new Request
                {
                    model = model,
                    messages = messages,
                    temperature = temperature,
                    max_tokens = maxTokens
                };

                string jsonData = serializer.Serialize(requestData);
                byte[] dataBytes = Encoding.UTF8.GetBytes(jsonData);

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baseUrl + "/chat/completions");
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Headers.Add("Authorization", "Bearer " + apiKey);
                request.ContentLength = dataBytes.Length;

                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(dataBytes, 0, dataBytes.Length);
                }

                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                using (Stream responseStream = response.GetResponseStream())
                using (StreamReader reader = new StreamReader(responseStream))
                {
                    string responseJson = reader.ReadToEnd();
                    Response apiResponse = serializer.Deserialize<Response>(responseJson);
                    if (apiResponse.choices.Count > 0)
                    {
                        return apiResponse.choices[0].message.content;
                    }
                    return string.Empty;
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public string GetCustomerResponse(string context, string customerContext)
        {
            List<Message> messages = new List<Message>
            {
                new Message { role = "system", content = "你是一个运营商的客户，正在与客服代表对话。请根据上下文和客户信息，生成自然、真实的客户回应。回应应该符合客户的角色和情境，不要过于正式，要像真实的人在说话。" },
                new Message { role = "user", content = "上下文：" + context + "\n客户信息：" + customerContext }
            };
            return GenerateResponse("deepseek-chat", messages);
        }

        public string EvaluateDialog(string dialogHistory, string scoringCriteria)
        {
            List<Message> messages = new List<Message>
            {
                new Message { role = "system", content = "你是一个运营商培训的裁判，负责评估学员与客户的对话。请根据对话历史和评分标准，对学员的表现进行评分和评价。评价应该客观、详细，指出优点和改进空间。" },
                new Message { role = "user", content = "评分标准：" + scoringCriteria + "\n对话历史：" + dialogHistory }
            };
            return GenerateResponse("deepseek-chat", messages);
        }
    }
}
