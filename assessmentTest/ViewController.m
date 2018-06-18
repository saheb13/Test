//
//  ViewController.m
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import "ViewController.h"
#import "Graph.h"
#import "ModelClass.h"
#import "ATAlertUtil.h"
#import <Charts/Charts.h>
#import "ATViewControllerManager.h"

@interface ViewController () {
    __weak ViewController *weakSelf;
}
@property (weak, nonatomic) IBOutlet BarChartView *barChartView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    weakSelf = self;
//    _dataArray = @[@4, @2, @1, @3, @5, @3, @2, @1, @5, @3];
    _dataArray = @[@4, @2, @1, @3];
    [self setupBarLineChartView:_barChartView];
    
    [self setUIPropertiesOfBarChart];
    
    [self loadBarchartStaticView];
}

#pragma mark - Private
- (void)setUIPropertiesOfBarChart {
    _barChartView.drawBarShadowEnabled = NO;
    _barChartView.drawValueAboveBarEnabled = YES;
    
    _barChartView.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = _barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 7;

    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = _barChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = _barChartView.rightAxis;
    rightAxis.enabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView {
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
    
}

- (void)loadBarchartStaticView {
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _dataArray.count; i++) {
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[_dataArray[i] doubleValue]]];
    }
    BarChartDataSet *set1 = nil;
    if (_barChartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)_barChartView.data.dataSets[0];
        set1.values = yVals;
        [_barChartView.data notifyDataChanged];
        [_barChartView notifyDataSetChanged];
    }
    else {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Values"];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _barChartView.data = data;
    }
    //animate barchart
    [_barChartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
}

- (void)loadBarchartDynamicView:(NSArray*)pArray {
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < pArray.count; i++) {
        Graph *graphObject = pArray[i];
//        double graphXVal = graphObject.index;
        double graphYVal = graphObject.value;
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:graphYVal]];
    }
    BarChartDataSet *set1 = nil;
    if (_barChartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)_barChartView.data.dataSets[0];
        set1.values = yVals;
        [_barChartView.data notifyDataChanged];
        [_barChartView notifyDataSetChanged];
    }
    else {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Values"];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _barChartView.data = data;
    }
    //animate barchart
    [_barChartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
}
#pragma mark- Fetch barchart data
- (void)fetchBarchartData {
    // Fetch Data from Server
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [[ATViewControllerManager sharedManager] chartData:@{} success:^(NSDictionary *dictionary) {
        NSLog(@" Success Dictionary %@",dictionary);
        [weakSelf handleSuccessResponse:dictionary];
        
    } failure:^(NSError *error) {
        [weakSelf handleFailure:error];
    }];
}

- (void)handleSuccessResponse:(NSDictionary*)pDictionary {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    ModelClass *chartModel = [[ModelClass alloc] initWithDictionary:pDictionary];
    [self loadBarchartDynamicView:chartModel.graph];
}

- (void)handleFailure:(NSError*)pError {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@" Error %@",pError);
    [ATAlertUtil showMessage:pError.description from:self];
}

#pragma mark- IBActions
- (IBAction)staticButtonAction:(id)sender {
    [self loadBarchartStaticView];
}

- (IBAction)dynamicButtonAction:(id)sender {
    [self fetchBarchartData];
}

@end
