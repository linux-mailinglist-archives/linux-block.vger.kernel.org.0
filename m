Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C7401795
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 10:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhIFIK3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Sep 2021 04:10:29 -0400
Received: from verein.lst.de ([213.95.11.211]:60552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240679AbhIFIK3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 04:10:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 154AE68AFE; Mon,  6 Sep 2021 10:09:21 +0200 (CEST)
Date:   Mon, 6 Sep 2021 10:09:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
        beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
        swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
        josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
        bvanassche@acm.org, ming.lei@redhat.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mmc@vger.kernel.org, dm-devel@redhat.com,
        nbd@other.debian.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/8] nvme: add error handling support for add_disk()
Message-ID: <20210906080921.GB25575@lst.de>
References: <20210830212538.148729-1-mcgrof@kernel.org> <20210830212538.148729-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830212538.148729-4-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-5.15.
