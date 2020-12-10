Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F22D54E1
	for <lists+linux-block@lfdr.de>; Thu, 10 Dec 2020 08:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgLJHuw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Dec 2020 02:50:52 -0500
Received: from verein.lst.de ([213.95.11.211]:52949 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgLJHuv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 02:50:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC72568AFE; Thu, 10 Dec 2020 08:50:08 +0100 (CET)
Date:   Thu, 10 Dec 2020 08:50:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: split hard read-only vs read-only policy v2
Message-ID: <20201210075008.GA13525@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207131918.2252553-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you pick this up for 5.11?
