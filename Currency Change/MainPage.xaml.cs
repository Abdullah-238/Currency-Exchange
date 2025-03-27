using System.Linq;
using System.Text.Json;

namespace Currency_Change
{
    public partial class MainPage : ContentPage
    {
        clsRates rates;

        SortedList<string,double> Currencies;

        public MainPage()
        {
            InitializeComponent();

            rates = new clsRates();

            Currencies = rates.Obj.conversion_rates;
        }

       

        private void ContentPage_Loaded(object sender, EventArgs e)
        {
            _Load();

        }

        void _Load()
        {
            pkfromCurrency.ItemsSource = clsConversionRate.CurrencyCodes;

            pkfromCurrency.SelectedIndex = 0;


            pktoCurrency.ItemsSource = clsConversionRate.CurrencyCodes;

            pktoCurrency.SelectedIndex = 50;


          
        }

   

        public double ConvertCurrency(string fromCurrency, string toCurrency, double amount)
        {
            if (!Currencies.ContainsKey(fromCurrency) || !Currencies.ContainsKey(toCurrency))
            {
                throw new ArgumentException("Invalid currency code");
            }

            double fromCurrencyRate = Currencies[fromCurrency];
            double toCurrencyRate = Currencies[toCurrency];


            double amountInBaseCurrency = amount / fromCurrencyRate;
            double convertedAmount = amountInBaseCurrency * toCurrencyRate;  

            return convertedAmount;
        }

        private async void Button_Clicked_1(object sender, EventArgs e)
        {
            if (!double.TryParse(enPriceChange.Text, out double number))
            {
                await DisplayAlert("Error", "Please enter a valid amount", "Done");
                return;
            }

            string fromCurrency = pkfromCurrency.SelectedItem.ToString(), toCurrency = pktoCurrency.SelectedItem.ToString();

            double amount = Convert.ToDouble(enPriceChange.Text);

            double Price = ConvertCurrency(fromCurrency, toCurrency, amount);

            enPriceAfterChanged.Text = Price.ToString();

        }
    }

}
