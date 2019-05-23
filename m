Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDB27A16
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2019 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEWKNe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 May 2019 06:13:34 -0400
Received: from verein.lst.de ([213.95.11.211]:45713 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfEWKNe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 06:13:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 88FB168AFE; Thu, 23 May 2019 12:13:11 +0200 (CEST)
Date:   Thu, 23 May 2019 12:13:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190523101311.GB15492@lst.de>
References: <20190522174812.5597-1-keith.busch@intel.com> <20190523032925.GA10601@ming.t460p> <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019 at 09:48:10PM -0600, Keith Busch wrote:
> Yeah, that's a good question. A FW update may have been initiated out
> of band or from another host entirely. The driver can't count on
> preparing for hardware pausing command processing before it's
> happened, but we'll always find out asynchronously after it's too late
> to freeze.

I don't think that is the case at least for spec compliant devices.

From NVMe 1.3:

Figure 49: Asynchronous Event Information - Notice

1h		Firmware Activation Starting: The controller is starting
		a firmware activation process during which command
		processing is paused. Host software may use CSTS.PP to
		determine when command processing has resumed. To clear
		this event, host software reads the Firmware Slot
		Information log page.

So we are supposed to get an AEN before the device stops processing
commands.
