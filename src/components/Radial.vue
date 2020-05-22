<template>
  <div>
    {{allLabels}}
    <div>
      <apexchart type="radialBar" height="390" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>
<script>
export default {
  name: "Radial",
  props: {
    chartDatas: {
      type: Array,
      required: true
      // default: () => []
    }
  },

  data() {
    return {
      newChartDatas: this.chartDatas,
      series: [],
      allSeries: [],
      chartOptions: {
        labels: [],
        allLabels: [],
        //chart
        chart: {
          height: 390,
          type: "radialBar"
        },

        //plotOptions
        plotOptions: {
          radialBar: {
            offsetY: 0,
            startAngle: 0,
            endAngle: 270,
            hollow: {
              margin: 5,
              size: "30%",
              background: "transparent",
              image: undefined
            },
            dataLabels: {
              name: {
                show: false
              },
              value: {
                show: false
              }
            }
          }
        },

        colors: ["#1ab7ea", "#0084ff", "#39539E", "#0077B5"],

        legend: {
          show: true,
          floating: true,
          fontSize: "16px",
          position: "left",
          offsetX: 160,
          offsetY: 15,
          labels: {
            useSeriesColors: true
          },
          markers: {
            size: 0
          },
          formatter: function(seriesName, opts) {
            return seriesName + ":  " + opts.w.globals.series[opts.seriesIndex];
          },
          itemMargin: {
            vertical: 3
          }
        },
        responsive: [
          {
            breakpoint: 480,
            options: {
              legend: {
                show: false
              }
            }
          }
        ]
      }
    };
  },

  //******************************************************** *//

  created() {
    // this.updateLabel();
    this.updateSeries();
    this.updateLabel();
  },

  methods: {
    updateSeries() {
      const newserie = this.allSeries;
      newserie.push(
        this.newChartDatas.map(el =>
          Math.round((el.sum * 100) / el.survey_topicQuote)
        )
      );

      const newData = this.allSeries[0].map(el => {
        return el;
      });
      this.series = newData;
    },

    updateLabel() {
      const newlabel = this.chartOptions.allLabels;

      newlabel.push(this.newChartDatas.map(el => el.survey_topicTitle));
      console.log("newLabel", newlabel);

      const newData2 = this.chartOptions.allLabels[0].map(x => {
        return x;
      });

      this.chartOptions.labels = newData2;
    }
  }
};
</script>

