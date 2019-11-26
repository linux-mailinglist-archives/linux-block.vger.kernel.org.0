Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6598310A261
	for <lists+linux-block@lfdr.de>; Tue, 26 Nov 2019 17:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfKZQnn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Nov 2019 11:43:43 -0500
Received: from verein.lst.de ([213.95.11.211]:41642 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKZQnm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 11:43:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1C5F68C4E; Tue, 26 Nov 2019 17:43:40 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:43:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] hpsa: switch to using blk-mq
Message-ID: <20191126164340.GB8108@lst.de>
References: <20191126131009.71726-1-hare@suse.de> <20191126131009.71726-9-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126131009.71726-9-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The subject is weird.  All SCSI drivers use blk-mq as there is no
other I/O path..
