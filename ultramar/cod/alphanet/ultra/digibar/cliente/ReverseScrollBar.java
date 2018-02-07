package alphanet.ultra.digibar.cliente;

import javax.swing.*;
import java.awt.event.AdjustmentListener;
import java.awt.event.AdjustmentEvent;

public class ReverseScrollBar extends JScrollBar {

	private static final long	serialVersionUID	= 1;
	private int vertScrollPrevMax = 0;
	private int vertScrollPrevExtent = 0;
	private int vertScrollPrevValue = 0;

	public ReverseScrollBar () {
		super();

		localInit();
	}

	public ReverseScrollBar (int orientation) {
		super (orientation);

		localInit();
	}

	public ReverseScrollBar (int orientation,
            int value,
            int extent,
            int min,
            int max) {
		super (orientation, value, extent, min, max);

		localInit();
	}


	private void updatePrevModel() {
		vertScrollPrevMax = model.getMaximum();
		vertScrollPrevExtent = model.getExtent();
		vertScrollPrevValue = model.getMinimum();
	}

	private void updateOnAdjustment() {

		// see if something new was added or the window resized
		if (model.getMaximum() != vertScrollPrevMax
				|| model.getExtent() != vertScrollPrevExtent) {
			// Yup ...

			// See if prev version was maxed
			if (vertScrollPrevValue + vertScrollPrevExtent >= vertScrollPrevMax) {
				// Yup ...

				setValue(Integer.MAX_VALUE);
			}
		} // if (newVertScrollBarModel.getMaximum()

		vertScrollPrevMax = model.getMaximum();
		vertScrollPrevExtent = model.getExtent();
		vertScrollPrevValue = model.getValue();
	}

	private void localInit() {

		updatePrevModel();

		addAdjustmentListener(new AdjustmentListener() {
			public void adjustmentValueChanged(AdjustmentEvent e) {
				updateOnAdjustment();
			}
		});
	}
}


