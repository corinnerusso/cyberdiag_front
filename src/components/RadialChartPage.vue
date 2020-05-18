<template>
  <div id="gauge">
    <p>{{chartDatas}}</p>
    <p>{{allDatas}}</p>
    <div class="charts">
      <div class="chart1">
        <apexchart type="radialBar" height="400" :options="chartOptions" :series="series"></apexchart>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    chartDatas: {
      type: Array,
      required: true,
      default: () => []
    }
  },
  data() {
    return {
      allDatas: this.chartDatas,

      series: [],
      series2: [70],
      chartOptions: {
        //chart
        chart: {
          height: 350,
          type: "radialBar",
          offsetY: -10
        },

        //plotOptions
        plotOptions: {
          radialBar: {
            startAngle: -135,
            endAngle: 135,
            dataLabels: {
              name: {
                fontSize: "16px",
                color: undefined,
                offsetY: 120
              },
              value: {
                offsetY: 76,
                fontSize: "22px",
                color: undefined,
                formatter: function(val) {
                  return val + "%";
                }
              }
            }
          }
        },

        //fill
        fill: {
          type: "gradient",
          gradient: {
            shade: "dark",
            shadeIntensity: 0.15,
            inverseColors: false,
            opacityFrom: 1,
            opacityTo: 1,
            stops: [0, 50, 65, 91]
          }
        },

        //stroke
        stroke: {
          dashArray: 4
        },

        //labels
        labels: []
      }
    };
  },

  //************************************************************* */

  created() {
    this.sendnewlabel();
    this.sendnewserie;
    console.log("lalal", this.sendnewserie());
  },

  methods: {
    sendnewlabel() {
      const newlabel = this.chartOptions.labels;
      return newlabel.push(this.allDatas[0].survey_topicTitle);
    },

    sendnewserie() {
      const newserie = this.series;
      return newserie.push(
        Math.round(
          (this.allDatas[0].sum * 100) / this.allDatas[0].survey_topicQuote
        )
      );
    }
  }
};
</script>

<style scoped>
</style>
    
