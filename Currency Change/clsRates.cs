using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Currency_Change
{
  
    public class clsRates : INotifyPropertyChanged
    {
       
        clsAPIobj _obj { get; set; }

        public clsAPIobj Obj
        {
            get => _obj;
            set
            {
                _obj = value;
                OnPropertyChanged();
            }
        }

        public clsRates()
        {
            Import();
        }
     
        public void Import()
        {
            try
            {
                String URLString = "https://v6.exchangerate-api.com/v6/19ed1657e22a016bda03d9a3/latest/USD";
                using (var webClient = new System.Net.WebClient())
                {
                    var json = webClient.DownloadString(URLString);
                    _obj = JsonConvert.DeserializeObject<clsAPIobj>(json);
                }
            }
            catch (Exception)
            {
                //return false;
            }
        }

        public event PropertyChangedEventHandler? PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

 
}