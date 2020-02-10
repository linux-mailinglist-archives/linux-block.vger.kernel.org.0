Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15AF158575
	for <lists+linux-block@lfdr.de>; Mon, 10 Feb 2020 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJW0B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Feb 2020 17:26:01 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33440 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgBJW0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 17:26:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 1B613283A7;
        Mon, 10 Feb 2020 17:25:57 -0500 (EST)
Date:   Tue, 11 Feb 2020 09:25:59 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Keith Busch <kbusch@kernel.org>
cc:     Tim Walker <tim.t.walker@seagate.com>, linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
In-Reply-To: <20200210204313.GA3736@dhcp-10-100-145-180.wdl.wdc.com>
Message-ID: <alpine.LNX.2.22.394.2002110914510.9@nippy.intranet>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com> <20200210204313.GA3736@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 10 Feb 2020, Keith Busch wrote:

> Right now the nvme driver unconditionally sets QUEUE_FLAG_NONROT 
> (non-rational, i.e. ssd), on all nvme namespace's request_queue flags. 

I agree -- the standard nomenclature is not rational ;-) Air-cooled is not 
"solid state". Any round-robin algorithm is "rotational". No expensive 
array is a "R.A.I.D.". There's no "S.C.S.I." on a large system...
