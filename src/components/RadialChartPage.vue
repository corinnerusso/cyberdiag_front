<template>
  <div id="gauge">
    <!-- <div v-for="(item, index) in series" v-bind:key="index">{{item}}</div> -->
    {{chartDatas[0].survey_surveyTitle}}
    {{chartOptions.labels}}
    <div>
      <apexchart
        v-for="(item, index) in series"
        v-bind:key="index"
        type="radialBar"
        height="400"
        :options="chartOptions"
        :series="[item]"
        :labels="labels"
      ></apexchart>
    </div>
  </div>
</template>

<script>
export default {
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
      series2: [1, 2, 3, 4],

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
        labels: [],
        allLabels: []
      }
    };
  },

  //************************************************************* */

  beforeUpdate() {
    this.updateLabel();
    this.updateSeries();
    // this.sendnewserie();
    // this.convert();
  },

  methods: {
    updateLabel() {
      const newlabel = this.chartOptions.allLabels;

      newlabel.push(this.newChartDatas.map(el => el.survey_topicTitle));

      const newData2 = this.chartOptions.allLabels[0].map(x => {
        return x;
      });

      this.chartOptions.labels = newData2;
    },

    // sendnewserie() {
    //   const newserie = this.allSeries;
    //   newserie.push(
    //     this.newChartDatas.map(el =>
    //       Math.round((el.sum * 100) / el.survey_topicQuote)
    //     )
    //   );
    // },

    // convert() {
    //   this.series = this.allSeries[0].map(el => {
    //     return el;
    //   });
    // },

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
      console.log("newSerie", this.series);
    }
  }
};
</script>

<style scoped>
</style>
    
